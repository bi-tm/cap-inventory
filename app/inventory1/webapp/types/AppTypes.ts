import type {
  PiDocumentType,
  ZewvaUiPiCount,
  ZewvaUiPiCountItm,
} from "inventory1/src-gen/main-service/ComSapGatewaySrvdA2xZewUiPiV0001Model";
import type { ZewvcUiUserParam } from "../src-gen/user-service/ComSapGatewaySrvdA2xZewUiUserParamV4V0001Model";

export type PiDoc = PiDocumentType;
export type PiHeader = Omit<ZewvaUiPiCount, "items">;
export type PiItem = ZewvaUiPiCountItm & { huDeleted: boolean };

export enum ROUTE {
  Home = "Home",
  Scan = "Scan",
  HuPi = "HuPi",
  BlkPi = "BlkPi",
}

export type DocKey = {
  docYear: string;
  docNumber: string;
  itemNo: string;
};

export type HuPiRouteParam = DocKey & { index?: string };

export type BlkPiRouteParam = DocKey;

export interface AppStateData {
  userParam: ZewvcUiUserParam | null; // Beututzerparameter (wird akturell mnicht benutzt)
  isInitialized: boolean;
  isLoggedIn: boolean;
  isLoading: boolean;
  error: string | null;
  showError: boolean;
  piDocuments: PiDoc[];
  piHeader: PiHeader | null;
  piItems: PiItem[];
  countOfHu: number; // Anzahl HU bei Blocklager Zählung
  scan: string; // scan Feld in Home view
  selectedTab: string; // ausgewählter Tab in HuPi View "1" oder "2"
  itemIndex: number; // ausgewählte countResult Zeile in HuPi View
  huScan: string; // Eingabe der HU Auswahl in HiPi, wenn mehrere HU vorhanden sind
}

export interface ODataErrorDetail {
  code: string;
  message: string;
  target?: string;
}

export interface ODataError {
  error: {
    code: string;
    message: string;
    details?: ODataErrorDetail[];
  };
}
