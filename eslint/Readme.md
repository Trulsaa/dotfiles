# Dependencies

## Airbnb extension installation
[eslint-config-airbnb](https://github.com/airbnb/javascript/tree/master/packages/eslint-config-airbnb)

### Usage

We export three ESLint configurations for your usage.

#### eslint-config-airbnb

Our default export contains all of our ESLint rules, including ECMAScript 6+ and React. It requires `eslint`, `eslint-plugin-import`, `eslint-plugin-react`, and `eslint-plugin-jsx-a11y`. If you don't need React, see [eslint-config-airbnb-base](https://npmjs.com/eslint-config-airbnb-base).

1. Install the correct versions of each package

  ```sh
  (
    export PKG=eslint-config-airbnb;
    npm info "$PKG@latest" peerDependencies --json | command sed 's/[\{\},]//g ; s/: /@/g' | xargs npm install --save-dev "$PKG@latest"
  )
  ```

  Which produces and runs a command like:

  ```sh
  npm install --save-dev eslint-config-airbnb eslint@^#.#.# eslint-plugin-jsx-a11y@^#.#.# eslint-plugin-import@^#.#.# eslint-plugin-react@^#.#.#
  ```

2. Add `"extends": "airbnb"` to your .eslintrc

## Markdown plugin installation
[eslint-plugin-markdown.git](https://github.com/eslint/eslint-plugin-markdown)

### Usage

Install the plugin:

```sh
npm install --save-dev eslint eslint-plugin-markdown
```

Add it to your `.eslintrc`:

```json
{
    "plugins": [
        "markdown"
    ]
}
```

Run ESLint on `.md` files:

```sh
eslint --ext md .
```
"plugins": ["html", "markdown"]

## HTML plugin installation
[eslint-plugin-html.git](https://github.com/BenoitZugmeyer/eslint-plugin-html)

### Usage

Simply install via `npm install --save-dev eslint-plugin-html` and add the plugin to your ESLint
configuration. See
[ESLint documentation](http://eslint.org/docs/user-guide/configuring#configuring-plugins).

Example:

```json
{
    "plugins": [
        "html"
    ]
}
```

Note: by default, when executing the `eslint` command on a directory, only `.js` files will be
linted. You will have to specify extra extensions with the `--ext` option. Example: `eslint --ext
.html,.js src` will lint both `.html` and `.js` files in the `src` directory. See [ESLint
documentation](http://eslint.org/docs/user-guide/command-line-interface#ext).
