// Leading characters that are invalid before an XML declaration/prolog and
// therefore must be trimmed: BOM / zero-width no-break space (U+FEFF), all
// whitespace, and other zero-width chars NOT in \s - ZWSP (U+200B), ZWNJ
// (U+200C), ZWJ (U+200D) and Word Joiner (U+2060). U+FEFF is listed explicitly
// (not left to \s): per ES2015+ \s should match it, but some engines (older
// WebKit/Safari - an affected browser here) do NOT, and relying on \s alone
// would make the fix silently do nothing for the BOM. The run stops at the
// first real character ('<'), so nothing inside the document is touched.
// Current Chrome no longer skips a leading BOM before the prolog, which breaks
// $.parseXML / DOMParser (throws "Content is not allowed in prolog").
var CLM_XML_PROLOG_NOISE = /^[\s\uFEFF\u200B\u200C\u200D\u2060]+/;

function stripXmlPrologNoise(text) {
    if (typeof text !== 'string') {
        return text;
    }
    return text.replace(CLM_XML_PROLOG_NOISE, '');
}

// Normalize every XML/.rels part in the given zip in place by stripping any
// invalid leading prolog noise. Non-XML parts (folders, media/images) are
// skipped, and parts are only rewritten when they actually change.
function normalizeXmlParts(zip) {
    if (!zip || !zip.files) {
        return;
    }
    Object.keys(zip.files).forEach(function(name) {
        var entry = zip.files[name];
        if (!entry || entry.dir || !/\.(xml|rels)$/i.test(name)) {
            return;
        }
        var text = entry.asText();
        var normalized = stripXmlPrologNoise(text);
        if (normalized !== text) {
            zip.file(name, normalized);
        }
    });
}

function parseContentTypes(zip) {
    var appendPNG = true;
    var deleteJPG = false;

    // Normalize every XML part up front so a stray BOM/whitespace/zero-width
    // char before the prolog can never break the $.parseXML calls below.
    normalizeXmlParts(zip);

    // check `Content_Types` for image extensions
    var contentTypesettings = zip.files["[Content_Types].xml"].asText();
    var CTXMLDoc = $.parseXML(contentTypesettings);
    $(CTXMLDoc).find('Default').each(function() {
        $.each(this.attributes, function(i, attrib) {
            var attrName = attrib.name;
            var attrValue = attrib.value;
            if (attrName === "Extension" && attrValue.toLowerCase() === "png") {
                appendPNG = false;
            }
            if (attrName === "Extension" && attrValue.toLowerCase() === "jpeg") {
                deleteJPG = true;
            }
        });
        if (deleteJPG === true) {
            $(this).remove();
            deleteJPG = false;
        }
        if (appendPNG === false) {
            return false;
        }
    });

    // if png extension is missing in `Content_Types`, then add it
    if (appendPNG === true) {
        var updateFieldsElement = $.parseXML("<Default/>").documentElement;
        var $updateFieldsElement = $(updateFieldsElement).attr({Extension: 'png', ContentType: 'image/png'});
        $(CTXMLDoc).children().append($updateFieldsElement);
        var cTypeSettingsRaw = (new XMLSerializer()).serializeToString(CTXMLDoc);
        cTypeSettingsRaw = cTypeSettingsRaw.replace(' xmlns=""', '');
        // https://github.com/open-xml-templating/docxtemplater/issues/240
        zip.file("[Content_Types].xml", cTypeSettingsRaw);
    }

    // convert all jpeg/jpg images to png
    if (zip["files"] !== undefined) {
        var fileObj = zip["files"];
        Object.keys(fileObj).forEach(function(key2) {
            var filesChild = fileObj[key2];
            if (key2.indexOf('word/_rels/header') != -1) {
                modifyHeaderXMLImageTypes(zip,filesChild);
            }
            if (key2.indexOf('word/media/') != -1) {
                modifyMediaImageTypes(zip,filesChild, fileObj);
            }
        });
    }
}

function modifyHeaderXMLImageTypes(zip, filesChild) {
    var folderPath = filesChild.name;
    var headerRels = getHeaderRelsFile(zip,folderPath);
    var headerXMLDoc = $.parseXML(headerRels);
    $(headerXMLDoc).find('Relationship').each(function() {
        $.each(this.attributes, function(i, attrib) {
            var name = attrib.name;
            var value = attrib.value;
            if (value.toLowerCase().endsWith('.jpeg')) {
                attrib.value = value.toLowerCase().replace('.jpeg', '.png');
            } else if (value.toLowerCase().endsWith('.jpg')) {
                attrib.value = value.toLowerCase().replace('.jpg', '.png');
            }
        });
    });
    var headerRelsRaw = (new XMLSerializer()).serializeToString(headerXMLDoc);
    zip.file(folderPath, headerRelsRaw);
}

function modifyMediaImageTypes(zip, filesChild, fileObj) {
    var name = filesChild.name;
    if (name.toLowerCase().endsWith('.jpeg')) {
        filesChild.name = name.toLowerCase().replace('.jpeg', '.png');
        fileObj[filesChild.name] = filesChild;
        zip.remove(name);
    } else if(name.toLowerCase().endsWith('.jpg')) {
        filesChild.name = name.toLowerCase().replace('.jpg', '.png');
        fileObj[filesChild.name] = filesChild;
        zip.remove(name);
    }
}

function getHeaderRelsFile(zip, path) {
    var file = zip.file(path);
    if (file != null) {
        // Strip prolog noise so the returned string parses even if this rels
        // part carries a leading BOM and was not normalized upstream.
        return stripXmlPrologNoise(file.asText());
    }
    return '';
}

function base64ToBlob(base64, contentType) {
    var binaryString = window.atob(base64);
    var len = binaryString.length;
    var bytes = new Uint8Array(len);
    for (var i = 0; i < len; ++i) {
        bytes[i] = binaryString.charCodeAt(i);
    }
    var type = contentType || 'application/pdf';
    return new Blob([bytes], { type: type });
};