import { read } from "node:fs"

export type ParamsType = {
    warehouse: string
}

export class Params {

    readonly warehouse: string = "1050";

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