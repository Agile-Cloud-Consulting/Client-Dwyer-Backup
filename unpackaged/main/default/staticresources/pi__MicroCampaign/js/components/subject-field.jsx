import React from 'react'
import { Svg } from '../salesforce-lightning-design-system'
import { warningIconMarkup } from '../svg'
import {
    parsePardotVariableTags,
    htmlToText,
} from '../util'
import { htmlDecode } from '../decoder'
import { isEdge, isInternetExplorer, isSafari, isFireFox } from '../../../../js/browser-check'
import { UnsupportedUserTags, SupportedTagsInPardot } from '../constants'
import ContentEditable from './content-editable.jsx'
import SubjectInput from './subject-input.jsx'
import { debugLog } from '../actions'
const isMsBrowser = isEdge() || isInternetExplorer()

const SubjectField = ({ isPreviewing, isSoboing, isLexTemplate, lastCursorPosition, subject, onChange, sendOnBehalfOf }) => {
    let { allOwnersInPardot, recipientPermissions } = sendOnBehalfOf;
    let allOwnersNotInPardot = recipientPermissions.loading === false && allOwnersInPardot === false;
    let sanitizedSubject = htmlDecode(subject).replace(/\\'/g, "'") || '';
    let unsupportedTags = isSoboing ? getUnsupportedVariableTags(sanitizedSubject) : [];
	let unsupportedLexTags = isLexTemplate ? getUnsupportedLexVariableTags(sanitizedSubject) : [];

    if (isPreviewing) {
		let text = sanitizedSubject;
		if (isSoboing) {
			if (unsupportedTags.length && allOwnersNotInPardot) {
				text = stripUnsupportedTags(text, unsupportedTags);
			}
		}
		if (isLexTemplate) {
			if (unsupportedLexTags.length) {
				text = stripUnsupportedTags(text, unsupportedLexTags);
			}
		}
        return renderSubjectPreview(text)
    } else {
        return renderEdit(subject, unsupportedTags, unsupportedLexTags, lastCursorPosition, isSoboing, isLexTemplate, onChange, sendOnBehalfOf)
    }
}

export default SubjectField

const renderSubjectPreview = (text) => {
    return (
        <div className="form-control slds-m-top--medium slds-truncate">
            <span className="label slds-float--left slds-text-align--right slds-p-right--small slds-text-color--weak" title={text}>Subject</span>
            <span>{text}</span>
        </div>
    )
}

const renderEdit = (subject, unsupportedTags, unsupportedLexTags, lastCursorPosition, isSoboing, isLexTemplate, onChange, sendOnBehalfOf) => {
    let { allOwnersInPardot, recipientPermissions } = sendOnBehalfOf;
    let allOwnersNotInPardot = recipientPermissions.loading === false && allOwnersInPardot === false;

    let shouldHighlightUnsupportedTags = false;
	let shouldHighlightUnsupportedLexTags = false;
	if (isSoboing) {
		shouldHighlightUnsupportedTags = ((unsupportedTags.length > 0) && allOwnersNotInPardot);
	}
	if (isLexTemplate) {
		shouldHighlightUnsupportedLexTags = (unsupportedLexTags.length > 0);
	}
    let errorClass = (shouldHighlightUnsupportedTags || shouldHighlightUnsupportedLexTags) && isMsBrowser ? 'slds-has-error' : '';

    return (
        <div className={errorClass}>
            <span>
                {(() => {
                    if ((shouldHighlightUnsupportedTags && shouldHighlightUnsupportedLexTags) && !isMsBrowser) {
						debugger;
						let tags = unsupportedTags.concat(unsupportedLexTags);
                        let props = {
                            subject,
                            tags,
                            lastCursorPosition,
                            onChange
                        }
						return <EditWithHighlightTags {...props} />
					} else if ((shouldHighlightUnsupportedTags && !shouldHighlightUnsupportedLexTags) && !isMsBrowser) {
						let tags = unsupportedTags;
						let props = {
                            subject,
                            tags,
                            lastCursorPosition,
                            onChange
                        }
						return <EditWithHighlightTags {...props} />
					} else if ((!shouldHighlightUnsupportedTags && shouldHighlightUnsupportedLexTags) && !isMsBrowser) {
						debugger;
						let tags = unsupportedLexTags;
						let props = {
                            subject,
                            tags,
                            lastCursorPosition,
                            onChange
                        }
                        return <EditWithHighlightTags {...props} />
                    } else {
                        let props = {
                            initialCursorPosition: lastCursorPosition,
                            onChange(event, lastCursorPosition) {
                                onChange(event.target.value, lastCursorPosition)
                            },
                            subject
                        }
                        return <SubjectInput {...props}/>
                    }
                })()}
            </span>
            {(() => {
                if (!isMsBrowser || (!shouldHighlightUnsupportedTags && !shouldHighlightUnsupportedLexTags)) {
                    return null
                }

                let s = unsupportedTags.length > 1 ? 's' : ''

                return (
                    <div className='slds-form-element__help'>
                        <span>Please correct unsupported tag{s}: </span>
                        {unsupportedTags.map(tag => (
                            <span key={tag}>
                                <b>{tag}</b>
                                <span> </span>
                            </span>
                        ))}
                    </div>
                )
            })()}
        </div>
    )
}

class EditWithHighlightTags extends React.Component {
    render() {
        let { subject, tags, lastCursorPosition, onChange } = this.props
        const contentChanged = (event, newLastCursorPosition) => {
            let value = htmlToText(event.target.value)
            if (value === subject) {
                return
            }

            onChange(value, newLastCursorPosition)
        }

        const shouldUpdate = (lastChildren) => {
            let numHighlightedDivs = lastChildren.reduce((total, child) => {
                return total + containsUnsupportedTagRef(child)
            }, 0)

            return tags.length !== numHighlightedDivs
        }

        let contentEditableProps = {
            onChange: contentChanged,
            shouldUpdate: shouldUpdate,
            initialCursorPosition: lastCursorPosition,
            suppressLineBreaks: true,
            ref: 'subject'
        }

		let splitText = splitTextByUnsupportedTags(subject, tags);
        let safari = isSafari() ? 'safari' : '';

        return (
            <div className={`slds-input highlighted ${safari}`}>
                <ContentEditable {...contentEditableProps} >
                    {splitText.map((subjectPart, i) => {
                        if (tags.includes(subjectPart)) {
                            return this.renderHighlightedTag(subjectPart, i)
                        } else {
                            return <span key={i}>{subjectPart}</span>
                        }
                    })}
                </ContentEditable>
            </div>
        )
    }

    renderHighlightedTag(tag, i) {
        return (
            <span contentEditable={true} key={i}>
                <span contentEditable={isEdge() || isFireFox()} className='highlighted-variable-tag' title='Unsupported Subject Variable Tag' ref={'unsupportedTag' + i}>
                    {renderWarningIcon()}
                    <span>{tag}</span>
                </span>
                <span>&#8203;</span>
            </span>
        )
    }

}

const renderWarningIcon = () => {
    let className = 'slds-input__icon slds-icon-text-default slds-icon--x-small slds-m-bottom--xx-small'
    if (isMsBrowser) {
        let props = {
            width: '1em',
            height: '1em',
            viewBox: '0 0 24 24'
        }

        return (
            <svg className={className} dangerouslySetInnerHTML={{ __html: warningIconMarkup() }} {...props} />
        )
    } else {
        return <Svg className={className} type={Svg.Types.Utility} symbol='warning' />
    }
}

const stripUnsupportedTags = (subject, tags) => {
    return tags.reduce((strippedSubject, tag) => {
        return strippedSubject.replace(new RegExp(tag, 'g'), '')
    }, subject)
}

const splitTextByUnsupportedTags = (text, tags) => {
    let regex = new RegExp(`(${tags.join('|')})`, 'g')
    return text.split(regex).filter(t => t)
}

const getUnsupportedVariableTags = (subject) => {
    return parsePardotVariableTags(subject).filter(tag => UnsupportedUserTags.includes(tag));
}

const getUnsupportedLexVariableTags = (subject) => {
	return parsePardotVariableTags(subject).filter(tag => !SupportedTagsInPardot.includes(tag.toLowerCase()));
}

const containsUnsupportedTagRef = (child) => {
    if (child.ref && child.ref.indexOf('unsupportedTag') > -1) {
        return true
    } else if (child.props && child.props.children instanceof Array) {
        return !!child.props.children.find(containsUnsupportedTagRef)
    } else {
        return false
    }
}
