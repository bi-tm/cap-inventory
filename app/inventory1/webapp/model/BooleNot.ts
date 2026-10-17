import SimpleType from "sap/ui/model/SimpleType";

export default class BooleNot extends SimpleType {
  formatValue(value: unknown): boolean {
    return !value;
  }

  parseValue(value: unknown): boolean {
    return !value;
  }

  // eslint-disable-next-line @typescript-eslint/no-unused-vars
  validateValue(_value: unknown): void {}
}
