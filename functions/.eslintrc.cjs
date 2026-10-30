module.exports = {
  env: {
    es6: true,
    node: true,
  },
  parserOptions: {
    "ecmaVersion": 2018,
    "sourceType": "module", // Added
  },
  extends: [
    "eslint:recommended",
    "google",
  ],
  rules: {
    // "max-len": ["off", { "code": 80 }], // Added By Me
    "no-restricted-globals": ["error", "name", "length"],
    "prefer-arrow-callback": "error",
    "quotes": ["error", "double", { "allowTemplateLiterals": true }],
    "linebreak-style": 0
  },
  overrides: [
    {
      files: ["**/*.spec.*"],
      env: {
        mocha: true,
      },
      rules: {},
    },
  ],
  globals: {},
};
