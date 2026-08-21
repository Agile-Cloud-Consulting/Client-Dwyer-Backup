import { LightningElement } from "lwc";
import DOCUMENTATION from "@salesforce/resourceUrl/BaseUtilitiesDocumentation";

export default class DocumentationViewer extends LightningElement {
    get documentationUrl() {
        return DOCUMENTATION;
    }
}