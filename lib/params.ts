import { read } from "node:fs"

export type ParamsType = {
    warehouse: string,
    user: string,
    resource: string,
}

export class Params {

    readonly warehouse: string = "1050";
    readonly user: string = "CB9980000340";
    readonly resource: string = "TMT";

    readonly CONST = {
        StatusActi: "ACTI"
    }

    async init(): Promise<Params> {
        return this;
    }

}

const params: Promise<Params> = new Params().init();

export default async function getParams(): Promise<Params> {
    return params;
}