import {env} from '../../../js/config-built'

export const SendOnBehalfOfOptions = {
	Self: 'self',
	LeadOwner: 'lead owner',
	ContactOwner: 'contact owner',
	AccountOwner: 'account owner'
}

export const AttachmentFilterOptions = {
	OwnedByMe: 'Owned by Me',
	SharedWithMe: 'Shared with Me'
}

export const HmlFieldFilterOptions = {
	Account: 'Account',
	Organization: 'Organization',
	Recipient: 'Recipient',
	Sender: 'Sender',
	Other: 'Other'
}

export const StandardObjects = {
	Lead: {
		Type: 'Lead',
		Prefix: '00Q'
	},
	Contact: {
		Type: 'Contact',
		Prefix: '003'
	},
	Account: {
		Type: 'Account',
		Prefix: '001'
	}
}

export const UnsupportedUserTags = [
	'%%user_crm_id%%',
	'%%user_html_signature%%',
	'%%user_job_title%%',
	'%%user_phone%%',
	'%%user_text_signature%%',
	'%%user_url%%',
	'{{sender.url}}',
	'{{{sender.url}}}',
	'{{sender.title}}',
	'{{{sender.title}}}',
	'{{sender.phone}}',
	'{{{sender.phone}}}',
	'{{sender.signature}}',
	'{{{sender.signature}}}'
]

export const SupportedTagsInPardot = [
	'{{{emailpreferencecenter}}}',
	'{{emailpreferencecenter}}',
	'{{{organization.address}}}',
	'{{recipient.account.accountnumber}}',
	'{{recipient.account.annualrevenue}}',
	'{{recipient.account.billingcity}}',
	'{{recipient.account.billingcountry}}',
	'{{recipient.account.billingpostalcode}}',
	'{{recipient.account.billingstate}}',
	'{{recipient.account.billingstreet}}',
	'{{recipient.account.fax}}',
	'{{recipient.account.industry}}',
	'{{recipient.account.name}}',
	'{{recipient.account.numberofemployees}}',
	'{{recipient.account.ownership}}',
	'{{recipient.account.phone}}',
	'{{recipient.account.rating}}',
	'{{recipient.account.shippingcity}}',
	'{{recipient.account.shippingcountry}}',
	'{{recipient.account.shippingpostalcode}}',
	'{{recipient.account.shippingstate}}',
	'{{recipient.account.shippingstreet}}',
	'{{recipient.account.sic}}',
	'{{recipient.account.site}}',
	'{{recipient.account.tickersymbol}}',
	'{{recipient.account.type}}',
	'{{recipient.account.website}}',
	'{{recipient.city}}',
	'{{recipient.comments}}',
	'{{recipient.company}}',
	'{{recipient.country}}',
	'{{recipient.department}}',
	'{{recipient.email}}',
	'{{recipient.fax}}',
	'{{recipient.firstname}}',
	'{{recipient.id}}',
	'{{recipient.industry}}',
	'{{recipient.lastname}}',
	'{{recipient.numberofemployees}}',
	'{{recipient.owner.email}}',
	'{{recipient.owner.firstname}}',
	'{{recipient.owner.lastname}}',
	'{{recipient.owner.name}}',
	'{{recipient.owner.phone}}',
	'{{recipient.ownerid}}',
	'{{recipient.phone}}',
	'{{recipient.postalcode}}',
	'{{recipient.salutation}}',
	'{{recipient.state}}',
	'{{recipient.street}}',
	'{{recipient.territory}}',
	'{{recipient.title}}',
	'{{recipient.website}}',
	'{{recipient.yearsinbusiness}}',
	'{{sender.email}}',
	'{{sender.firstname}}',
	'{{sender.lastname}}',
	'{{sender.name}}',
	'{{sender.phone}}',
	'{{sender.signature}}',
	'{{sender.title}}',
	'{{sender.url}}',
	'{{subject}}',
	'{{unsubscribe}}',
	'{{resubscribe}}',
	'{{addthis_url_email}}',
	'{{addthis_url_facebook}}',
	'{{addthis_url_linkedin}}',
	'{{addthis_url_more}}',
	'{{addthis_url_twitter}}',
	'{{view_online}}',
	'{{current_day}}',
	'{{current_month}}',
	'{{current_year}}',
	'{{{recipient.account.accountnumber}}}',
	'{{{recipient.account.annualrevenue}}}',
	'{{{recipient.account.billingcity}}}',
	'{{{recipient.account.billingcountry}}}',
	'{{{recipient.account.billingpostalcode}}}',
	'{{{recipient.account.billingstate}}}',
	'{{{recipient.account.billingstreet}}}',
	'{{{recipient.account.fax}}}',
	'{{{recipient.account.industry}}}',
	'{{{recipient.account.name}}}',
	'{{{recipient.account.numberofemployees}}}',
	'{{{recipient.account.ownership}}}',
	'{{{recipient.account.phone}}}',
	'{{{recipient.account.rating}}}',
	'{{{recipient.account.shippingcity}}}',
	'{{{recipient.account.shippingcountry}}}',
	'{{{recipient.account.shippingpostalcode}}}',
	'{{{recipient.account.shippingstate}}}',
	'{{{recipient.account.shippingstreet}}}',
	'{{{recipient.account.sic}}}',
	'{{{recipient.account.site}}}',
	'{{{recipient.account.tickersymbol}}}',
	'{{{recipient.account.type}}}',
	'{{{recipient.account.website}}}',
	'{{{recipient.city}}}',
	'{{{recipient.comments}}}',
	'{{{recipient.company}}}',
	'{{{recipient.country}}}',
	'{{{recipient.department}}}',
	'{{{recipient.email}}}',
	'{{{recipient.fax}}}',
	'{{{recipient.firstname}}}',
	'{{{recipient.id}}}',
	'{{{recipient.industry}}}',
	'{{{recipient.lastname}}}',
	'{{{recipient.numberofemployees}}}',
	'{{{recipient.owner.email}}}',
	'{{{recipient.owner.firstname}}}',
	'{{{recipient.owner.lastname}}}',
	'{{{recipient.owner.name}}}',
	'{{{recipient.owner.phone}}}',
	'{{{recipient.ownerid}}}',
	'{{{recipient.phone}}}',
	'{{{recipient.postalcode}}}',
	'{{{recipient.salutation}}}',
	'{{{recipient.state}}}',
	'{{{recipient.street}}}',
	'{{{recipient.territory}}}',
	'{{{recipient.title}}}',
	'{{{recipient.website}}}',
	'{{{recipient.yearsinbusiness}}}',
	'{{{sender.email}}}',
	'{{{sender.firstname}}}',
	'{{{sender.lastname}}}',
	'{{{sender.name}}}',
	'{{{sender.phone}}}',
	'{{{sender.signature}}}',
	'{{{sender.title}}}',
	'{{{sender.url}}}',
	'{{{subject}}}',
	'{{{unsubscribe}}}',
	'{{{resubscribe}}}',
	'{{{addthis_url_email}}}',
	'{{{addthis_url_facebook}}}',
	'{{{addthis_url_linkedin}}}',
	'{{{addthis_url_more}}}',
	'{{{addthis_url_twitter}}}',
	'{{{view_online}}}',
	'{{{current_day}}}',
	'{{{current_month}}}',
	'{{{current_year}}}'
];

export const Environment = env
export const Environments = {
	Prod: 'prod',
	Dev: 'dev'
}

export const Bullet = '•'

export const FileTypes = {
	'image': ['JPG', 'JPEG', 'GIF', 'BMP', 'PNG', 'SVG'],
	'csv': ['CSV'],
	'pdf': ['PDF'],
	'ppt': ['PPT'],
	'keynote': ['KEY', 'KEYNOTE'],
	'mp4': ['MP4'],
	'pages': ['PGS'],
	'excel': ['XLS', "EXCEL_X", "EXCEL"],
	'psd': ['PSD'],
	'rtf': ['RTF'],
	'txt': ['TXT', 'TEXT'],
	'word': ['DOC', 'DOCX', 'WORD', 'WORD_X'],
	'xml': ['XML'],
	'zip': ['ZIP']
}

export const AttachmentImageClass = 'sfdc-internal-attachment-inline-image';
export const AttachmentDeleteClass = 'sfdc-internal-attachment-delete';
export const AttachmentCardClass = 'sfdc-internal-attachment-card';
export const AttachmentContainerClass = 'sfdc-internal-attachment-container';
export const AttachmentContainerEditTabClass = 'sfdc-internal-attachment-container-edit';
export const AttachmentLinkClass = 'sfdc-internal-attachment-link';
export const AttachmentLinkTargetClass = 'sfdc-internal-attachment-link-target';
export const AttachmentProgressBarContainerClass = 'sfdc-internal-attachment-progress-bar-container';
export const AttachmentProgressBarClass = 'sfdc-internal-attachment-progress-bar';
export const MicrosoftBrowserClass = 'is-microsoft-browser';

export const PiSldsAssetsPath = 'https://pi.pardot.com/assets/microcampaign/slds/assets';

export const EditorMinimumHeight = 100;
export const EditorKyleSmidgeHeight = 39;
export const EditorAttachmentCardBreakpoint = 300;

export const UploadErrors = {
	UploadFileEmpty: 'UPLOAD FILE EMPTY',
	UploadFileTooLarge: 'UPLOAD FILE TOO LARGE',
	FileNotImageUploadError: 'ATTEMPTING TO UPLOAD NON IMAGE FILE',
	StorageLimitExceededError: 'STORAGE_LIMIT_EXCEEDED',
	GenericUploadError: 'GENERIC UPLOAD ERROR',
	ImageMayNotRender: 'UPLOAD FILE MAY NOT RENDER IN CLIENT'
}

export const MaxFileSizeInBytes = 2000000000;
export const MayNotRenderOnClientFileSizeInBytes = 25000000;

export const AttachmentTypes = {
	None: '0',
	File: '1',
	Image: '2',
	FileAndImage: '3'
}

export const MaximumEngageEmailRecipients = 200;

// If you don't want to limit indent level, comment this line
export const MaximumFolderTreeIndentLevel = 5;

export const ClassicFooterOffset = 110;

export const UnsubscribeLinkHtml = '<a href="%%unsubscribe%%" rel="nofollow,noreferrer">Unsubscribe</a>';
export const UnsubscribeLinkHtmlHML = '<a href="{{Unsubscribe}}" rel="nofollow,noreferrer">Unsubscribe</a>';

export const InsufficientPrivilegeError = 'Insufficient Privilege';
export const SomeRecipientsInaccessibleErrorTitle = 'Recipients removed from your email';
export const SomeRecipientsInaccessibleErrorMessage = ' email recipient(s) were removed from your email because you no longer have access to view their records. Review the remaining recipients and click Send.';
export const AllRecipientsInaccessibleErrorTitle = 'Couldn\'t send your email';
export const AllRecipientsInaccessibleErrorMessage = 'We couldn\'t send your email because you no longer have access to view the records for the email recipients. To send the email, please re-create the Engage Campaign and add recipients whose records you can view.';
