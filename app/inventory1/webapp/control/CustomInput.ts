import Input from "sap/m/Input";
import { ValueState } from "sap/ui/core/library";

/**
 * input field
 * - text is marked, when field gets focus
 * - property "error" to set ValueState and valueStateText together
 */
export default class CustomInput extends Input {
  static readonly metadata = {
    properties: {
      error: {
        type: "string",
        defaultValue: "",
      },
    },
    events: {
      focus: {},
      focusout: {},
    },
  };

  static renderer = "sap.m.InputRenderer";

  setError(error: string): void {
    this.setProperty("error", error, true);
    this.setProperty("valueStateText", error, true);
    this.setProperty(
      "valueState",
      error.length ? ValueState.Error : ValueState.None
    );
  }

  // public onAfterRendering(): void {
  //   const input = this.$().find("input");

  //   input.focus(() => {
  //     this.fireEvent("focus");
  //     input.select();
  //   });

  //   input.focusout(() => {
  //     this.fireEvent("focusout");
  //   });
  // }
}
