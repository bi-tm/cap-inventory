// see https://github.com/ui5-community/ui5-ecosystem-showcase/pull/706/files#diff-b874ac56436e8f64d082347ce9968b83182016884ae684206d786797cda567e9
/* eslint-disable */

/**
 * This file contains the type safe facade "TypeSafeJSONModel" for "JSONModel".
 *
 * Since TypeSafeJSONModel is only a type it has no runtime differences or overhead compared to the JSONModel.
 *
 * The JSONModel class is used to store data which has to be synchronized with the view. JSONModel mainly uses the
 * getProperty() and setProperty() methods to access the stored values. To specify which property should be
 * returned the JSONModel uses the names of the object keys and '/' as a separator to access nested properties.
 * E.g. if we have the object <code>{ foo: 'FOO', bar: { baz: 'BAZ' }}</code> we could use '/foo' to access
 * the string "FOO", '/bar' to access the object <code>{ baz: 1 }</code> or '/bar/baz' to access the string
 * "BAZ".
 *
 * The purpose of TypeSafeJSONModel is to add typechecking at compile time. This means that the returned
 * properties have the correct type, instead of the <code>any</code> type that the JSONModel returns by
 * default. Additionally, accessing non-existent properties will cause type errors at compile time.
 */

import JSONModel from "sap/ui/model/json/JSONModel";

/**
 * JSON safe value
 */
type JSONScalar = string | boolean | number | Date | null;

/**
 * JSON safe array
 */
export type JSONArray = (JSONScalar | JSONObject)[];

/**
 * JSON safe object
 */
export type JSONObject = {
  [x: string]: JSONScalar | JSONObject | JSONArray;
};

/**
 * Type to represent JSONModels content
 *
 * We disallow scalar values as roots since UI5 doesn't allow it
 */
type TypeSafeJSONModelData = JSONArray | JSONObject | {};

/**
 * Type safe facade over UI5's JSONModel
 *
 * @see JSONModel
 */
export interface TypeSafeJsonModel<
  D extends TypeSafeJSONModelData,
> extends JSONModel {
  constructor: (oData: D, bObserve?: boolean) => this;
  setData: (oData: Partial<D>, bMerge?: boolean) => void;
  getData: () => D;
}

export const createJsonModel = <D extends TypeSafeJSONModelData>(
  data: D
): TypeSafeJsonModel<D> => {
  return new JSONModel(data) as TypeSafeJsonModel<D>;
};
