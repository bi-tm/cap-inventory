using {inventory1} from './piDocument';

namespace com.sap.gateway.srvd_a2x.zew_ui_pi;

service v0001 {
    entity PiDocument as projection on inventory1.PiDocument
        actions {
            action StartCounting(in: many $self, Scan: String) returns inventory1.ZewvaUiPiCount;
        };
}
