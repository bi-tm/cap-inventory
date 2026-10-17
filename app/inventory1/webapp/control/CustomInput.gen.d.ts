import Event from "sap/ui/base/Event";
import { PropertyBindingInfo } from "sap/ui/base/ManagedObject";
import { $InputSettings } from "sap/m/Input";

declare module "./CustomInput" {

    /**
     * Interface defining the settings object used in constructor calls
     */
    interface $CustomInputSettings extends $InputSettings {
        error?: string | PropertyBindingInfo;
        focus?: (event: CustomInput$FocusEvent) => void;
        focusout?: (event: CustomInput$FocusoutEvent) => void;
    }

    export default interface CustomInput {

        // property: error
        getError(): string;
        setError(error: string): this;

        // event: focus
        attachFocus(fn: (event: CustomInput$FocusEvent) => void, listener?: object): this;
        attachFocus<CustomDataType extends object>(data: CustomDataType, fn: (event: CustomInput$FocusEvent, data: CustomDataType) => void, listener?: object): this;
        detachFocus(fn: (event: CustomInput$FocusEvent) => void, listener?: object): this;
        fireFocus(parameters?: CustomInput$FocusEventParameters): this;

        // event: focusout
        attachFocusout(fn: (event: CustomInput$FocusoutEvent) => void, listener?: object): this;
        attachFocusout<CustomDataType extends object>(data: CustomDataType, fn: (event: CustomInput$FocusoutEvent, data: CustomDataType) => void, listener?: object): this;
        detachFocusout(fn: (event: CustomInput$FocusoutEvent) => void, listener?: object): this;
        fireFocusout(parameters?: CustomInput$FocusoutEventParameters): this;
    }

    /**
     * Interface describing the parameters of CustomInput's 'focus' event.
     */
    // eslint-disable-next-line
    export interface CustomInput$FocusEventParameters {
    }

    /**
     * Interface describing the parameters of CustomInput's 'focusout' event.
     */
    // eslint-disable-next-line
    export interface CustomInput$FocusoutEventParameters {
    }

    /**
     * Type describing the CustomInput's 'focus' event.
     */
    export type CustomInput$FocusEvent = Event<CustomInput$FocusEventParameters>;

    /**
     * Type describing the CustomInput's 'focusout' event.
     */
    export type CustomInput$FocusoutEvent = Event<CustomInput$FocusoutEventParameters>;
}
