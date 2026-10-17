import CoreService from "./CoreService";
import ODataClientFactory from "./ODataClientFactory";

export default class UserService extends CoreService {
  private static instance: UserService;

  private constructor() {
    super();
  }

  public static getInstance(): UserService {
    if (!UserService.instance) {
      UserService.instance = new UserService();
    }
    return UserService.instance;
  }

  public async getUserParams(): Promise<void> {
    return this.execute(async () => {
      const client = ODataClientFactory.getUserServiceClient();
      const result = await client.userParam().getUserParam();
      const param = result.data;
      this.appState.setUserParam({
        plant: param.plant,
        rsrc: param.rsrc,
        username: param.username,
        warehouse: param.warehouse,
      });
    });
  }

  public async rsrcLogon(warehouse: string, rsrc: string): Promise<void> {
    return this.execute(async () => {
      const client = ODataClientFactory.getUserServiceClient();
      await client.userParam().rsrcLogon({ warehouse, rsrc });
      this.appState.logIn();
    });
  }

  public async rsrcLogoff(warehouse: string, rsrc: string): Promise<void> {
    return this.execute(async () => {
      const client = ODataClientFactory.getUserServiceClient();
      await client.userParam().rsrcLogoff({ warehouse, rsrc });
      this.appState.logOut();
    });
  }
}
