import { LightningElement, wire, api, track } from 'lwc';

export default class InAppLanding extends LightningElement {
    @api welcome_text = "Welcome to the Education Cloud Learning Org";
    @api description = "Get Started with Education Cloud";

    get pass_false() {
        return false;
    }

    get pass_true() {
        return true;
    }

}