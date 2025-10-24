//
//  index.js
//  CodeMirror
//
//  Created by Eliomar Alejandro Rodriguez Ferrer on 25/10/25.
//

import { LRLanguage, LanguageSupport } from "@codemirror/language";
import { parser } from "./riscv.grammar.js";
import { HighlightStyle, tags } from "@codemirror/highlight";

// definisci il linguaggio
export const rv32iLanguage = LRLanguage.define({
  parser: parser,
  languageData: {
	commentTokens: { line: "//" },
  }
});

// definisci colori dei token
export const rv32iHighlight = HighlightStyle.define([
  { tag: tags.keyword, color: "#ff9f1c" },      // istruzioni e direttive
  { tag: tags.variableName, color: "#2ec4b6" }, // registri
  { tag: tags.number, color: "#8ac926" },       // numeri
  { tag: tags.labelName, color: "#e71d36" },    // label
  { tag: tags.string, color: "#9d4edd" },       // stringhe
]);

// funzione da importare
export function rv32i() {
  return new LanguageSupport(rv32iLanguage, [rv32iHighlight]);
}
