import { execFileSync } from "node:child_process";
import type { ExtensionAPI } from "@earendil-works/pi-coding-agent";

// Shared reporter contract: set pane options @agent_pid and @agent_state
// (working | waiting | ready). The picker treats missing/mismatched reports as unknown.
export default function (pi: ExtensionAPI) {
  const pane = process.env.TMUX_PANE ?? "";
  if (!pane) return;

  function report(state?: "working" | "waiting" | "ready") {
    try {
      for (const [key, value] of [["@agent_pid", String(process.pid)], ["@agent_state", state]]) {
        execFileSync("tmux", ["set-option", "-p", "-t", pane, ...(value ? [key, value] : ["-u", key])], {
          stdio: "ignore",
        });
      }
    } catch {
      // A detached/closed tmux server must not interrupt Pi.
    }
  }

  pi.on("session_start", () => report());
  pi.on("agent_start", () => report("working"));
  pi.on("ui_prompt_start", () => report("waiting"));
  pi.on("ui_prompt_end", () => report("working"));
  pi.on("agent_settled", () => report("ready"));
  pi.on("session_shutdown", () => {
    try {
      for (const key of ["@agent_pid", "@agent_state"])
        execFileSync("tmux", ["set-option", "-p", "-t", pane, "-u", key], { stdio: "ignore" });
    } catch {
      // The pane may already be gone.
    }
  });
}
