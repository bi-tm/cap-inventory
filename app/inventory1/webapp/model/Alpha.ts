import String from "sap/ui/model/type/String";
import ValidateException from "sap/ui/model/ValidateException";

type FormatOptionsType = {
  length?: number;
};

export default class Alpha extends String {
  private formatOptions: FormatOptionsType = { length };

  constructor(formatOptions?: FormatOptionsType) {
    super();
    if (formatOptions) {
      this.formatOptions = formatOptions;
    }
  }

  formatValue(value: unknown): string {
    if (typeof value === "string") {
      const valueUpper = value.trim().toLocaleUpperCase();
      if (valueUpper.match(/[A-Z]/)) {
        return valueUpper;
      } else {
        return valueUpper.replace(/^0*/, "");
      }
    } else {
      return "";
    }
  }

  parseValue(value: unknown): string {
    if (typeof value === "string") {
      let result = value.trim().toUpperCase();
      if (this.formatOptions.length) {
        result = result.slice(0, this.formatOptions.length);
        if (result.match(/^[0-9]+$/)) {
          result = result.padStart(this.formatOptions.length, "0");
        }
      }
      return result;
    } else {
      return "";
    }
  }

  validateValue(value: unknown): void {
    if (
      this.formatOptions.length &&
      typeof value === "string" &&
      value.length > this.formatOptions.length
    ) {
      // eslint-disable-next-line @typescript-eslint/only-throw-error
      throw new ValidateException(
        `maximal ${this.formatOptions.length} Zeichen möglich`
      );
    }
  }
}
