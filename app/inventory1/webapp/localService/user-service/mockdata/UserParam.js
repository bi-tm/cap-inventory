module.exports = {
  async executeAction(actionDefinition, actionData) {
    if (actionDefinition.name === "GetUserParam") {
      return {
        Plant: "1010",
        Rsrc: "STAPLER-01",
        Username: "LOCAL_USER",
        Warehouse: "1710",
      };
    }
    return actionData;
  },
};
