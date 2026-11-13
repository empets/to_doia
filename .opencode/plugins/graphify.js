// graphify OpenCode plugin (OpenCode v2 API)
// Injects a knowledge graph reminder before shell tool calls when the graph exists.
//
// IMPORTANT: keep the reminder string free of backticks and $(...) constructs.
// The hook prepends `echo "<reminder>" ; <cmd>` to the user's shell command;
// backticks inside the double-quoted echo trigger shell command substitution,
// which both corrupts tool output and silently executes the very graphify
// command we are only suggesting. Plain words render fine in opencode's TUI.
import { existsSync } from "node:fs";
import { join } from "node:path";

const REMINDER =
  "[graphify] knowledge graph at graphify-out/. For focused questions, run graphify query with your question (scoped subgraph, usually much smaller than GRAPH_REPORT.md) instead of grepping raw files. Read GRAPH_REPORT.md only for broad architecture context.";

// OpenCode v2 requires a default export carrying a stable id and a setup
// function. The v1 shape (named export returning a hooks object) is rejected
// at load time with "Plugin must export a default definition with an id and an
// effect or setup function".
export default {
  id: "graphify.reminder",
  async setup(ctx) {
    const directory = ctx.location.directory;
    if (!existsSync(join(directory, "graphify-out", "graph.json"))) return;

    let reminded = false;

    await ctx.tool.hook("execute.before", (event) => {
      if (reminded) return;
      // The shell tool was renamed from `bash` to `shell` in OpenCode v2.
      if (event.tool !== "shell" && event.tool !== "bash") return;

      const input = event.input;
      if (!input || typeof input.command !== "string") return;

      // ';' not '&&' — Windows PowerShell 5.1 rejects '&&' as a statement
      // separator, breaking the first shell command of the session (#1646).
      event.input = {
        ...input,
        command: `echo "${REMINDER}" ; ${input.command}`,
      };
      reminded = true;
    });
  },
};
