var clientSidePdfGenerationConfig;
function handleMessage(event) {
    // @W-23232762: Check if the origin of event is same as the current window origin.
    // Wrapped in try/catch: reading window.parent.location.origin throws a SecurityError
    // when the iframe is cross-origin with its parent; treat that as an untrusted message.
    try {
        if (event.origin !== window.parent.location.origin) {
            return;
        }
    } catch (e) {
        return; // cross-origin parent — treat as untrusted
    }
    if (event.isTrusted && typeof event.data === 'object') {
        switch (event.data.type) {
            case 'LOAD_CORE_CONTROLS':
                clientSidePdfGenerationConfig = event.data.params;
                console.log(clientSidePdfGenerationConfig);
                // @W-18591716: CheckMarx : validate URL scheme before assigning to script.src
                // to reject javascript:/data:/etc. injected via postMessage params.
                var coreControlsUrl = clientSidePdfGenerationConfig && clientSidePdfGenerationConfig['core_controls'];
                var parsedCoreControlsUrl;
                try {
                    parsedCoreControlsUrl = new URL(coreControlsUrl, window.location.href);
                } catch (e) {
                    return;
                }
                if (parsedCoreControlsUrl.protocol !== 'https:' && parsedCoreControlsUrl.protocol !== 'http:') {
                    return;
                }
                var script = document.createElement('script');
                script.onload = function () {
                    init(clientSidePdfGenerationConfig);
                };
                script.src = encodeURI(coreControlsUrl);

                document.head.appendChild(script);
                window.removeEventListener("message", handleMessage);
                break;
            default:
                break;
        }
    }
}

window.addEventListener("message", handleMessage, false);

parent.postMessage({ type: 'REQUEST_PARAMS' }, '*');


function init(clientSidePdfGenerationConfig) {
  console.log(`%c initialize CoreControls `, 'background: red; color: white;');
    window.Core.forceBackendType('ems');
    //window.Core.setPDFWorkerPath(clientSidePdfGenerationConfig['cs_pdftron_full']);
    window.Core.setWorkerPath(clientSidePdfGenerationConfig['cs_pdftron_lib']+'/core');
    window.Core.setPDFWorkerPath(clientSidePdfGenerationConfig['cs_pdftron_lean']);
    
    window.Core.setOfficeWorkerPath(clientSidePdfGenerationConfig['cs_pdftron_office']);
    window.Core.setPDFResourcePath(clientSidePdfGenerationConfig['cs_pdftron_resource']);
    window.Core.setPDFAsmPath(clientSidePdfGenerationConfig['cs_pdftron_asm']);
    window.Core.setExternalPath(clientSidePdfGenerationConfig['cs_pdftron_external']);

    //Set the path for Fonts
    window.Core.setCustomFontURL(clientSidePdfGenerationConfig['cs_vlocity_webfonts_main'] + '/');

    //Set the path for office workers
    window.Core.setOfficeAsmPath(clientSidePdfGenerationConfig['cs_pdftron_officeasm']);
    window.Core.setOfficeResourcePath(clientSidePdfGenerationConfig['cs_pdftron_officeresource']);
    window.Core.disableEmbeddedJavaScript(true)

    console.log(Core);
    console.log(window.Core.PDFNet);


    generatePDFTronDocument()
    .then(function(pdfContent){
        console.log(`%c Post message back to parent `, 'background: green; color: white;');
        parent.postMessage({type: 'PDF_GENERATION_COMPLETE', payload: pdfContent}, '*')
    }, function(error) {

    });
}

function generatePDFTronDocument(inputMap){
    console.log('client side generation enabled...');
    var l = clientSidePdfGenerationConfig.pdfIntegrationConfig;
    l = atob(l);
    console.log('initialize');
    return   window.Core.PDFNet.initialize(l).then(function(){
        //The logic needs to be different for New Template attachment
        if( clientSidePdfGenerationConfig.VersionData != null &&  clientSidePdfGenerationConfig.VersionData !== undefined){
                var blob = base64ToBlob(clientSidePdfGenerationConfig.VersionData, 'application/vnd.openxmlformats-officedocument.wordprocessingml.document');
                console.log("blob=", blob);
                var fileExtension = clientSidePdfGenerationConfig.fileExtension; 
                return convertOfficeToPDF(blob, 'clientSidePdfGenerationConfig' + '.pdf', l, fileExtension).then(function(res){
                    var response = {
                        contentVersionData : res,
                        docxContentVersionId : clientSidePdfGenerationConfig.docxContentVersionId
                    }
                    console.log('conversion done');
                    return response;
                });
        }
    }).then(function(res) {
        console.log('PDF ATTACHMENT Complete!');
        return res;
    });
}

function convertOfficeToPDF(blob, outputName, l, fileExtension) {
    console.log('convertOfficeToPDF');
    //console.log('url=' + url);
    console.log('outputName=' + outputName);
    console.log('fileExtension='+ fileExtension);
    return new Promise(function (resolve, reject){

        try {
            Core.createDocument(blob, {extension: fileExtension, l: l }).then((doc) => {
                var options = {
                  downloadType: 'pdf'
                };

                doc.getDocumentCompletePromise().then(() => {
                    // call file data API to get raw PDF data
                    setTimeout(function(error) {
                        doc.getFileData(options).then((data) => {
                            var base64PDFContent = getBase64(data, outputName, 'application/pdf');
                            resolve(base64PDFContent);
                        })
                        .catch( function(error) {
                            console.log('error=', error);
                            reject(error);
                        })
                        .finally( function() {
                            console.log('finally');
                        });
                    },1000);
                }).catch(function(error) {
                    console.log('doc.getDocumentCompletePromise error=', error);
                    reject(error);
                });

              });
        } catch (error) {
            console.log('error=', error);
        }
        console.log('DONE');
    });
}

 /**
 *
 */
function saveBuffer(buf, name, mimetype) {
  var blob = new Blob([buf], {
    type: mimetype
  });
        saveAs(blob, name);
}

/**
 *
 */
function saveBufferAsPDFDoc(buf, name) {
    saveBuffer(buf, name, 'application/pdf');
}

var getBase64 = function (buf, name, mimetype) {
   var base64 =  arrayBufferToBase64(buf);
   return pdfContent = base64;
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

var arrayBufferToBase64 = function( buffer ) {
    var binary = '';
    var bytes = new Uint8Array( buffer );
    var len = bytes.byteLength;
    for (var i = 0; i < len; i++) {
        binary += String.fromCharCode( bytes[ i ] );
    }
    return window.btoa( binary );
}