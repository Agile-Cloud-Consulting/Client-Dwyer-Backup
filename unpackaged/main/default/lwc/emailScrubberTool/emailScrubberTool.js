import { LightningElement, wire } from 'lwc';
import hasRunEmailScrubber from '@salesforce/customPermission/Run_Email_Scrubber';
import getAllConfigs  from '@salesforce/apex/EmailScrubberController.getAllConfigs';
import getObjects     from '@salesforce/apex/EmailScrubberController.getObjects';
import getEmailFields from '@salesforce/apex/EmailScrubberController.getEmailFields';
import saveConfig     from '@salesforce/apex/EmailScrubberController.saveConfig';
import startScrub     from '@salesforce/apex/EmailScrubberController.startScrub';
import getJobStatus   from '@salesforce/apex/EmailScrubberController.getJobStatus';
import isSandbox      from '@salesforce/apex/EmailScrubberController.isSandbox';
import LightningConfirm from 'lightning/confirm';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

const POLL_INTERVAL_MS  = 3000;
const TERMINAL_STATUSES = ['Completed', 'Failed', 'Aborted'];
const SEARCH_DEBOUNCE   = 300;

export default class EmailScrubberTool extends LightningElement {

    configs          = [];
    jobId            = null;
    statusLabel      = '';
    progressText     = '';
    errorText        = '';
    errorMessage     = '';
    isRunning        = false;

    // Form state
    showForm          = false;
    isEditing         = false;
    isSaving          = false;
    formLabel         = '';
    formDeveloperName = '';
    formObject        = '';
    formField         = '';
    formIsActive      = true;

    // Object search
    objectOptions      = [];
    objectFilter       = '';
    isSearchingObjects = false;

    // Field options
    fieldOptions     = [];
    isLoadingFields  = false;

    // null = not yet loaded, true = sandbox, false = production
    sandboxStatus = null;

    pollTimer         = null;
    objectSearchTimer = null;

    @wire(isSandbox)
    wiredIsSandbox({ error, data }) {
        if (data !== undefined) {
            this.sandboxStatus = data;
        } else if (error) {
            // Default to treating as production so the warning always shows on failure
            this.sandboxStatus = false;
        }
    }

    get isProduction() {
        return this.sandboxStatus === false;
    }

    get noPermission() {
        return !hasRunEmailScrubber;
    }

    get isNewDisabled() {
        return this.showForm || this.noPermission;
    }

    get isRunDisabled() {
        return this.isRunning || this.noPermission;
    }

    get isEditDisabled() {
        return this.showForm || this.noPermission;
    }

    connectedCallback() {
        this.loadConfigs();
    }

    async loadConfigs() {
        try {
            const result = await getAllConfigs();
            this.configs = result.map(cfg => ({
                developerName : cfg.developerName,
                label         : cfg.label,
                object        : cfg.object,
                field         : cfg.field,
                isActive      : cfg.isActive,
                activeLabel   : cfg.isActive ? 'Yes' : 'No'
            }));
        } catch (e) {
            this.errorMessage = 'Failed to load configurations.';
        }
    }

    // ── Form ─────────────────────────────────────────────────────────────────

    get formTitle() {
        return this.isEditing ? 'Edit Configuration' : 'New Configuration';
    }

    get isFieldDisabled() {
        return !this.formObject || this.isLoadingFields;
    }

    get fieldPlaceholder() {
        if (!this.formObject)          return 'Select an object first';
        if (this.isLoadingFields)      return 'Loading fields...';
        if (!this.fieldOptions.length) return 'No email fields found';
        return 'Select an email field';
    }

    get objectPlaceholder() {
        return this.objectOptions.length ? 'Select an object' : 'Type to search...';
    }

    handleNew() {
        this.isEditing          = false;
        this.formLabel          = '';
        this.formDeveloperName  = '';
        this.formObject         = '';
        this.formField          = '';
        this.formIsActive       = true;
        this.objectFilter       = '';
        this.objectOptions      = [];
        this.fieldOptions       = [];
        this.showForm           = true;
    }

    async handleEdit(event) {
        const developerName = event.target.dataset.developerName;
        const cfg = this.configs.find(c => c.developerName === developerName);
        if (!cfg) return;

        this.isEditing          = true;
        this.formLabel          = cfg.label;
        this.formDeveloperName  = cfg.developerName;
        this.formObject         = cfg.object;
        this.formField          = cfg.field;
        this.formIsActive       = cfg.isActive;
        this.objectFilter       = '';
        this.fieldOptions       = [];
        this.showForm           = true;

        // Pre-load options so the comboboxes show the saved values
        await Promise.all([
            this.searchObjects(cfg.object),
            this.loadFieldOptions(cfg.object)
        ]);
    }

    handleCancel() {
        this.showForm = false;
    }

    handleLabelChange(event) {
        this.formLabel = event.target.value;
        if (!this.isEditing) {
            this.formDeveloperName = this.toDeveloperName(this.formLabel);
        }
    }

    handleDeveloperNameChange(event) {
        this.formDeveloperName = event.target.value;
    }

    handleObjectFilterChange(event) {
        this.objectFilter = event.target.value;
        clearTimeout(this.objectSearchTimer);
        // eslint-disable-next-line @lwc/lwc/no-async-operation
        this.objectSearchTimer = setTimeout(() => {
            this.searchObjects(this.objectFilter);
        }, SEARCH_DEBOUNCE);
    }

    async searchObjects(term) {
        this.isSearchingObjects = true;
        try {
            this.objectOptions = await getObjects({ searchTerm: term });
        } catch (e) {
            this.showToast('Error', 'Failed to load objects.', 'error');
        } finally {
            this.isSearchingObjects = false;
        }
    }

    async handleObjectChange(event) {
        this.formObject   = event.detail.value;
        this.formField    = '';
        this.objectFilter = '';
        await this.loadFieldOptions(this.formObject);
    }

    handleFieldChange(event) {
        this.formField = event.detail.value;
    }

    handleActiveChange(event) {
        this.formIsActive = event.target.checked;
    }

    async loadFieldOptions(objectApiName) {
        if (!objectApiName) {
            this.fieldOptions = [];
            return;
        }
        this.isLoadingFields = true;
        try {
            this.fieldOptions = await getEmailFields({ objectApiName });
        } catch (e) {
            this.showToast('Error', 'Failed to load fields for ' + objectApiName + '.', 'error');
            this.fieldOptions = [];
        } finally {
            this.isLoadingFields = false;
        }
    }

    async handleSave() {
        if (!this.formLabel || !this.formDeveloperName || !this.formObject || !this.formField) {
            this.showToast('Missing Fields', 'All fields are required.', 'error');
            return;
        }

        this.isSaving = true;
        try {
            await saveConfig({
                developerName     : this.formDeveloperName,
                label             : this.formLabel,
                objectApiName     : this.formObject,
                emailFieldApiName : this.formField,
                isActive          : this.formIsActive
            });
            this.showToast(
                'Deployment Queued',
                'Configuration saved. Refresh in a few seconds to see the new record.',
                'success'
            );
            this.showForm = false;
        } catch (e) {
            this.showToast('Save Failed', e.body?.message || 'An error occurred.', 'error');
        } finally {
            this.isSaving = false;
        }
    }

    // ── Run ──────────────────────────────────────────────────────────────────

    handleRefresh() {
        this.loadConfigs();
    }

    async handleRun() {
        if (this.isProduction) {
            const confirmed = await LightningConfirm.open({
                label:   'Production Org Warning',
                message: 'You are in a production org. Running the Email Scrubber will permanently modify real email data on all configured objects. This cannot be undone. Are you sure you want to continue?',
                variant: 'headerless'
            });
            if (!confirmed) return;
        }

        this.isRunning    = true;
        this.jobId        = null;
        this.statusLabel  = 'Starting...';
        this.progressText = '';
        this.errorText    = '';
        this.errorMessage = '';

        try {
            this.jobId = await startScrub();
            this.showToast('Batch Started', `Job ID: ${this.jobId}`, 'success');
            this.pollStatus();
        } catch (e) {
            this.isRunning    = false;
            this.errorMessage = e.body?.message || 'Failed to start batch job.';
        }
    }

    pollStatus() {
        this.pollTimer = setInterval(async () => {
            try {
                const result = await getJobStatus({ jobId: this.jobId });
                this.statusLabel  = result.status;
                this.progressText = `${result.processed} of ${result.total} batches processed`;
                this.errorText    = result.errors > 0
                    ? `${result.errors} error(s): ${result.extendedStatus || ''}`
                    : '';

                if (TERMINAL_STATUSES.includes(result.status)) {
                    clearInterval(this.pollTimer);
                    this.isRunning = false;

                    if (result.status === 'Completed' && result.errors === 0) {
                        this.showToast('Scrub Complete', 'All email fields have been updated.', 'success');
                    } else if (result.status === 'Failed' || result.errors > 0) {
                        this.showToast('Scrub Finished with Errors', this.errorText, 'warning');
                    }
                }
            } catch (e) {
                clearInterval(this.pollTimer);
                this.isRunning    = false;
                this.errorMessage = 'Error polling job status.';
            }
        }, POLL_INTERVAL_MS);
    }

    // ── Utilities ────────────────────────────────────────────────────────────

    get statusClass() {
        const map = {
            'Completed' : 'slds-theme_success',
            'Failed'    : 'slds-theme_error',
            'Aborted'   : 'slds-theme_warning'
        };
        return map[this.statusLabel] || '';
    }

    toDeveloperName(label) {
        return label
            .replace(/[^a-zA-Z0-9]+/g, '_')
            .replace(/^[^a-zA-Z]+/, '')
            .replace(/_+$/, '')
            .substring(0, 40);
    }

    showToast(title, message, variant) {
        this.dispatchEvent(new ShowToastEvent({ title, message, variant }));
    }

    disconnectedCallback() {
        clearTimeout(this.objectSearchTimer);
        if (this.pollTimer) clearInterval(this.pollTimer);
    }
}