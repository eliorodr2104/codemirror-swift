//
//  index.js
//  CodeMirror
//
//  Created by Eliomar Alejandro Rodriguez Ferrer on 25/10/25.
//

// src/lang-rv32i/index.js
import { LRLanguage, LanguageSupport } from "@codemirror/language";
import { parser } from "./riscv.grammar.js";

export const rv32iLanguage = LRLanguage.define({
  parser: parser,
  languageData: {
	commentTokens: { line: "//" },
  },
});

export function rv32i() {
  return new LanguageSupport(rv32iLanguage);
}
