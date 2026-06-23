// Generates the GLM-5.2 / z.ai summary deck.
// Run: NODE_PATH=$(npm root -g) node make_deck.js
const pptxgen = require("pptxgenjs");
const pres = new pptxgen();
pres.layout = "LAYOUT_16x9"; // 10" x 5.625"
pres.author = "Brando Miranda";
pres.title = "GLM-5.2 as a Claude Code Backend";

const C = {
  ink: "0C2B27", teal: "0E7C7B", tealD: "0A5C57", tealTint: "E6F0EF", tealL: "9AD0CC",
  gold: "E0A33E", light: "F4F7F6", card: "FFFFFF", text: "16332F", muted: "5C7370",
  warn: "B0503F", warnTint: "F3EAE7", slate: "7C746C", slateTint: "EEEDEA",
};
const HEAD = "Cambria", BODY = "Calibri";
const shadow = () => ({ type: "outer", color: "0C2B27", blur: 7, offset: 3, angle: 90, opacity: 0.16 });

function titleBar(s, text, dark) {
  s.addText(text, { x: 0.6, y: 0.42, w: 8.8, h: 0.8, fontFace: HEAD, fontSize: 30, bold: true,
    color: dark ? "FFFFFF" : C.text, align: "left", valign: "middle", margin: 0 });
}

// ---- Slide 1: Title (dark) ----
let s = pres.addSlide();
s.background = { color: C.ink };
s.addShape(pres.shapes.OVAL, { x: 7.4, y: -1.7, w: 4.4, h: 4.4, fill: { color: C.tealD } });
s.addShape(pres.shapes.OVAL, { x: 8.9, y: 2.5, w: 1.15, h: 1.15, fill: { color: C.gold } });
s.addText("GLM-5.2 as a Claude Code Backend", { x: 0.65, y: 2.0, w: 6.5, h: 1.5,
  fontFace: HEAD, fontSize: 38, bold: true, color: "FFFFFF", valign: "top", margin: 0 });
s.addText("z.ai's cheap, non-lazy alternative to Claude Opus", { x: 0.65, y: 3.6, w: 6.6, h: 0.5,
  fontFace: BODY, fontSize: 16, italic: true, color: C.tealL, margin: 0 });
s.addText("Notes from a group chat   ·   2026-06-23   ·   Brando Miranda", { x: 0.65, y: 4.55,
  w: 7.6, h: 0.4, fontFace: BODY, fontSize: 12, color: "8FB3AF", margin: 0 });

// ---- Slide 2: What is GLM-5.2 (light) ----
s = pres.addSlide();
s.background = { color: C.light };
titleBar(s, "What is GLM-5.2?");
const facts = [
  ["New model from z.ai", "A Chinese AI lab; widely praised right now."],
  ["Large — and not self-hostable", "~700B parameters (estimate), so running it yourself is generally infeasible."],
  ["Cheap and capable", "A colleague: “surprisingly good (much better than Claude Opus), very cheap.”"],
];
let y = 1.55;
facts.forEach(([h, d]) => {
  s.addShape(pres.shapes.OVAL, { x: 0.62, y: y + 0.05, w: 0.17, h: 0.17, fill: { color: C.gold } });
  s.addText([
    { text: h + "\n", options: { bold: true, fontSize: 16, color: C.text, breakLine: true } },
    { text: d, options: { fontSize: 13.5, color: C.muted } },
  ], { x: 0.95, y: y - 0.02, w: 4.75, h: 1.0, fontFace: BODY, valign: "top", margin: 0 });
  y += 1.15;
});
s.addShape(pres.shapes.ROUNDED_RECTANGLE, { x: 6.05, y: 1.55, w: 3.35, h: 3.05, rectRadius: 0.12, fill: { color: C.ink }, shadow: shadow() });
s.addText("~700B", { x: 6.05, y: 1.95, w: 3.35, h: 0.9, align: "center", fontFace: HEAD, fontSize: 50, bold: true, color: C.gold, margin: 0 });
s.addText("parameters (est.)", { x: 6.05, y: 2.85, w: 3.35, h: 0.4, align: "center", fontFace: BODY, fontSize: 13, color: C.tealL, margin: 0 });
s.addText("Not as good as the retired Claude Fable — but close, and far cheaper.", { x: 6.35, y: 3.4, w: 2.75, h: 1.0, align: "center", fontFace: BODY, fontSize: 12.5, italic: true, color: "DCE8E6", margin: 0 });

// ---- Slide 3: Why over Opus (compare, light) ----
s = pres.addSlide();
s.background = { color: C.light };
titleBar(s, "Why a colleague prefers it over Opus");
s.addShape(pres.shapes.ROUNDED_RECTANGLE, { x: 0.6, y: 1.55, w: 4.25, h: 3.35, rectRadius: 0.1, fill: { color: C.tealTint }, shadow: shadow() });
s.addText("GLM-5.2", { x: 0.6, y: 1.7, w: 4.25, h: 0.5, align: "center", fontFace: HEAD, fontSize: 20, bold: true, color: C.tealD, margin: 0 });
s.addText([
  { text: "Does what it says it will do", options: { bullet: true, breakLine: true, paraSpaceAfter: 10 } },
  { text: "Not lazy — doesn't give up", options: { bullet: true, breakLine: true, paraSpaceAfter: 10 } },
  { text: "Problem-solving feels deeper than Claude or Codex", options: { bullet: true } },
], { x: 1.0, y: 2.35, w: 3.5, h: 2.4, fontFace: BODY, fontSize: 14.5, color: C.text, valign: "top" });
s.addShape(pres.shapes.ROUNDED_RECTANGLE, { x: 5.15, y: 1.55, w: 4.25, h: 3.35, rectRadius: 0.1, fill: { color: C.slateTint }, shadow: shadow() });
s.addText("Claude Opus", { x: 5.15, y: 1.7, w: 4.25, h: 0.5, align: "center", fontFace: HEAD, fontSize: 20, bold: true, color: C.slate, margin: 0 });
s.addText([
  { text: "Too much “maddening hand-waving”", options: { bullet: true, breakLine: true, paraSpaceAfter: 10 } },
  { text: "Incompleteness — leaves work unfinished", options: { bullet: true, breakLine: true, paraSpaceAfter: 10 } },
  { text: "Pushing them toward dropping Claude Max", options: { bullet: true } },
], { x: 5.55, y: 2.35, w: 3.5, h: 2.4, fontFace: BODY, fontSize: 14.5, color: "4A4540", valign: "top" });

// ---- Slide 4: Setup steps (light) ----
s = pres.addSlide();
s.background = { color: C.light };
titleBar(s, "Setting it up in Claude Code");
const steps = [
  ["1", "Subscribe to z.ai", "Max-like plan at z.ai/model-api."],
  ["2", "Add a router", "claude-code-switch or claude-code-router."],
  ["3", "Keep everything", "All your memories & settings work equivalently."],
];
let x = 0.62; const cw = 2.75, gap = 0.30;
steps.forEach(([n, h, d]) => {
  s.addShape(pres.shapes.ROUNDED_RECTANGLE, { x, y: 1.75, w: cw, h: 2.45, rectRadius: 0.1, fill: { color: C.card }, shadow: shadow() });
  s.addShape(pres.shapes.OVAL, { x: x + cw / 2 - 0.42, y: 2.0, w: 0.84, h: 0.84, fill: { color: C.teal } });
  s.addText(n, { x: x + cw / 2 - 0.42, y: 2.0, w: 0.84, h: 0.84, align: "center", valign: "middle", fontFace: HEAD, fontSize: 30, bold: true, color: "FFFFFF", margin: 0 });
  s.addText(h, { x: x + 0.15, y: 3.05, w: cw - 0.3, h: 0.5, align: "center", fontFace: HEAD, fontSize: 17, bold: true, color: C.text, margin: 0 });
  s.addText(d, { x: x + 0.2, y: 3.55, w: cw - 0.4, h: 0.65, align: "center", fontFace: BODY, fontSize: 12.5, color: C.muted, margin: 0 });
  x += cw + gap;
});
s.addText("Integration is easy — “Claude itself helped me set it up.”", { x: 0.6, y: 4.6, w: 8.8, h: 0.5, align: "center", fontFace: BODY, fontSize: 13, italic: true, color: C.tealD, margin: 0 });

// ---- Slide 5: The cost hack (dark) ----
s = pres.addSlide();
s.background = { color: C.ink };
titleBar(s, "The cost hack", true);
s.addShape(pres.shapes.ROUNDED_RECTANGLE, { x: 0.6, y: 1.5, w: 8.8, h: 1.25, rectRadius: 0.12, fill: { color: C.tealD }, shadow: shadow() });
s.addText([
  { text: "z.ai's Claude Code endpoint is tied to your subscription — ", options: { color: "FFFFFF" } },
  { text: "not pay-as-you-go.", options: { color: C.gold, bold: true } },
], { x: 1.0, y: 1.5, w: 8.0, h: 1.25, valign: "middle", fontFace: HEAD, fontSize: 21, margin: 0 });
const pts = [
  "Reuse the same endpoint for batch jobs, data processing & general API tasks",
  "Big savings vs pay-per-token — it draws on subscription quota, not your wallet",
  "“Like an almost-Fable model for routine data-processing magic.”",
];
let yy = 3.05;
pts.forEach((p) => {
  s.addShape(pres.shapes.OVAL, { x: 0.7, y: yy + 0.04, w: 0.16, h: 0.16, fill: { color: C.gold } });
  s.addText(p, { x: 1.02, y: yy - 0.05, w: 8.2, h: 0.55, fontFace: BODY, fontSize: 15, color: "E7F0EE", valign: "top", margin: 0 });
  yy += 0.72;
});

// ---- Slide 6: Trade-offs (light) ----
s = pres.addSlide();
s.background = { color: C.light };
titleBar(s, "Trade-offs");
s.addShape(pres.shapes.ROUNDED_RECTANGLE, { x: 0.6, y: 1.55, w: 4.25, h: 3.1, rectRadius: 0.1, fill: { color: C.warnTint }, shadow: shadow() });
s.addText("Downside", { x: 0.6, y: 1.72, w: 4.25, h: 0.5, align: "center", fontFace: HEAD, fontSize: 20, bold: true, color: C.warn, margin: 0 });
s.addText([
  { text: "GPU-limited capacity", options: { bullet: true, breakLine: true, paraSpaceAfter: 12 } },
  { text: "Peak windows drain your usage quota faster", options: { bullet: true } },
], { x: 1.0, y: 2.45, w: 3.5, h: 1.9, fontFace: BODY, fontSize: 15, color: "5A463F", valign: "top" });
s.addShape(pres.shapes.ROUNDED_RECTANGLE, { x: 5.15, y: 1.55, w: 4.25, h: 3.1, rectRadius: 0.1, fill: { color: C.tealTint }, shadow: shadow() });
s.addText("Upside", { x: 5.15, y: 1.72, w: 4.25, h: 0.5, align: "center", fontFace: HEAD, fontSize: 20, bold: true, color: C.tealD, margin: 0 });
s.addText([
  { text: "Peak windows = China working hours", options: { bullet: true, breakLine: true, paraSpaceAfter: 12 } },
  { text: "So it's off-peak during US daytime", options: { bullet: true } },
], { x: 5.55, y: 2.45, w: 3.5, h: 1.9, fontFace: BODY, fontSize: 15, color: C.text, valign: "top" });

// ---- Slide 7: Considerations (light) ----
s = pres.addSlide();
s.background = { color: C.light };
titleBar(s, "Before adopting — considerations");
const cons = [
  ["Terms of service", "Confirm z.ai allows the integration endpoint for general batch / API jobs."],
  ["Data governance", "Third-party, China-hosted API — check lab / IRB rules for unpublished work."],
  ["Fits Hard Rule 9", "Use the CLI scaffold; wrap any batch use behind a self-throttling CLI layer."],
  ["Benchmark first", "Compare vs Opus / Codex on real tasks: Lean/ATP, writing, agentic coding."],
];
let y2 = 1.55;
cons.forEach(([h, d]) => {
  s.addShape(pres.shapes.OVAL, { x: 0.62, y: y2 + 0.02, w: 0.34, h: 0.34, fill: { color: C.teal } });
  s.addText([
    { text: h + "   ", options: { bold: true, color: C.text } },
    { text: "— " + d, options: { color: C.muted } },
  ], { x: 1.12, y: y2 - 0.02, w: 8.1, h: 0.8, fontFace: BODY, fontSize: 14.5, valign: "top", margin: 0 });
  y2 += 0.82;
});

// ---- Slide 8: Next steps (dark) ----
s = pres.addSlide();
s.background = { color: C.ink };
titleBar(s, "Next steps", true);
const acts = [
  "Try GLM-5.2 via claude-code-router on a throwaway task; compare to Opus",
  "Read z.ai pricing + ToS (z.ai/model-api)",
  "Decide keep-vs-drop on Claude Max after a week side-by-side",
  "Follow up: how was the subscription-tied endpoint discovered?",
];
let y3 = 1.55;
acts.forEach((a) => {
  s.addShape(pres.shapes.OVAL, { x: 0.7, y: y3 + 0.02, w: 0.28, h: 0.28, fill: { color: C.gold } });
  s.addText(a, { x: 1.15, y: y3 - 0.03, w: 8.1, h: 0.6, fontFace: BODY, fontSize: 15.5, color: "E7F0EE", valign: "top", margin: 0 });
  y3 += 0.78;
});
s.addText("Source: group chat, 2026-06-23", { x: 0.7, y: 5.0, w: 8.6, h: 0.4, fontFace: BODY, fontSize: 11, color: "7FA39F", margin: 0 });

const OUT = "/Users/brandomiranda/brandomiranda/experiments/13_glm_zai_claude_code_backend/glm5.2_zai_claude_code_backend_summary.pptx";
pres.writeFile({ fileName: OUT }).then((f) => console.log("wrote " + f));
