import { ApplicationService } from "@sap/cds";
import PiDocument from "./piDocument";

export default class Inventory extends ApplicationService {

    piDocumentService = new PiDocument();

    async init() {
        await this.piDocumentService.register(this);
        return super.init();
    }

}
