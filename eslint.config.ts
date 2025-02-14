import config from '@rogwilco/defaults-eslint'
import type { Linter } from 'eslint'

export default [
  {
    ignores: ['**/dist'],
  },
  ...config,
] satisfies Linter.Config[]
