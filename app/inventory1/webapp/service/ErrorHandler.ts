export default class ErrorHandler {
  private static instance: ErrorHandler;

  private constructor() {}

  public static getInstance(): ErrorHandler {
    if (!ErrorHandler.instance) {
      ErrorHandler.instance = new ErrorHandler();
    }
    return ErrorHandler.instance;
  }

  /** TODO: After various changes this could be a exportet function. No singleton needed anymore */
  public parseError(error: unknown): string {
    if (error instanceof Error) {
      return (error.cause as Error)?.message ?? error.message;
    }

    return "An unknown error occurred";
  }
}
