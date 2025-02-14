import type { Options } from 'prettier'

export default {
  arrowParens: 'avoid',
  plugins: [
    'prettier-plugin-multiline-arrays',
    'prettier-plugin-organize-imports',
    'prettier-plugin-packagejson',
    'prettier-plugin-sh',
    'prettier-plugin-terraform-formatter',
  ],
  multilineArraysWrapThreshold: 1,
  semi: false,
  singleQuote: true,
  trailingComma: 'all',
  printWidth: 80,
} satisfies Options
