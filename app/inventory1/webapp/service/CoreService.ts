import AppState from "../model/AppState";
import ErrorHandler from "./ErrorHandler";

/**
 * Abstrakte Basis-Klasse für alle Services.
 * Übernimmt automatisch:
 * - Loading State (Ladebalken)
 * - Error Handling (MessageBox)
 *
 * Verwendung: class WarehouseService extends CoreService { ... }
 */
export default abstract class CoreService {
  protected readonly appState: AppState;
  private readonly errorHandler: ErrorHandler;

  protected constructor() {
    this.appState = AppState.getInstance();
    this.errorHandler = ErrorHandler.getInstance();
  }

  /**
   * Wrapper für jeden Service-Call.
   * Setzt automatisch Loading State und fängt Fehler ab.
   *
   * @example
   * async loadWarehouse(): Promise<Warehouse> {
   *   return this.execute(() => this.client.getWarehouse());
   * }
   */
  protected async execute<T>(operation: () => Promise<T>): Promise<T> {
    this.appState.clearError();
    this.appState.setLoading(true);
    try {
      const result = await operation();
      return result;
    } catch (error: unknown) {
      this.setErrorMessage(this.errorHandler.parseError(error));
      throw error;
    } finally {
      this.appState.setLoading(false);
    }
  }
  public setErrorMessage(message: string): void {
    this.appState.setError(message);
  }

  public clearError(): void {
    this.appState.clearError();
  }
}
