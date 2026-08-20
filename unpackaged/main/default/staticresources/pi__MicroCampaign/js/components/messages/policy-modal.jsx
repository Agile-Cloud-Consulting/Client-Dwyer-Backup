import React from 'react';
import ConfirmModal from './confirm-modal.jsx';
import Dispatcher from '../../dispatcher';
import ActionTypes from '../../action-types';
import PropTypes from 'prop-types';

const policyUrl = 'http://www.pardot.com/company/legal/permission-based-marketing-policy/';
const consentManagementUrl = 'http://www.pardot.com/company/legal/permission-based-marketing-policy/';

export default class PolicyModal extends React.Component {
	confirmClicked() {
		Dispatcher.dispatch({
			type: ActionTypes.CONFIRM_POLICY
		})
	}

	cancelClicked() {
		Dispatcher.dispatch({
			type: ActionTypes.CANCEL_POLICY
		})
	}

	getPolicyModalBody(appendUnsubscribe) {
		if (appendUnsubscribe) {
			return (
				<div>	
						<p>
							Emails sent to more than 10 people are considered marketing emails.
							To continue, confirm that you:
						</p>
							<ul className='slds-list_dotted'>
								<li>
									Have a business relationship with these recipients and that this message complies with&nbsp;
									<a href={policyUrl} target='_blank'>Pardot's permission based marketing policy</a>.
								</li>
								<li>Understand that the required unsubscribe link is automatically added to your email footer.</li>
							</ul>
					</div>	
			);
		}
		return (
			<p>
				Emails sent to more than 10 people are considered marketing emails. 
				To continue, confirm that you have a business relationship with these 
				contacts and that this message complies with&nbsp;
				<a href={policyUrl} target='_blank'>Pardot's permission based marketing policy</a>.
			</p>
		);
	} 

	render() {
		let { appendUnsubscribe } = this.props;
		
		return (
			<ConfirmModal title='Send Engage Email?'
				confirmText='Confirm and Send'
				callback={this.confirmClicked} cancelCallback={this.cancelClicked}>
				{this.getPolicyModalBody(appendUnsubscribe)}
			</ConfirmModal>
		);
	}
}
PolicyModal.propTypes = {
    appendUnsubscribe: PropTypes.bool.isRequired
}