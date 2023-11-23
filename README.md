# fourmolu.el

Format Haskell source code using [fourmolu](https://fourmolu.github.io).  Requires [reformatter.el](https://github.com/purcell/reformatter.el).

See also Vasily Yorkin's [ormolu.el](https://github.com/vyorkin/ormolu.el), which this is based on.

# Usage

With [use-package](https://github.com/jwiegley/use-package/):

```elisp
(use-package fourmolu
 :hook (haskell-mode . fourmolu-format-on-save-mode)
 :bind
 (:map haskell-mode-map
   ("C-c r" . fourmolu-format-buffer)))
```

Without:

```elisp
(push "~/.elib/contrib/reformatter.el" load-path)
(push "~/.elib/contrib/fourmolu.el" load-path)
(load-library "fourmolu")
(add-hook 'haskell-mode-hook 'fourmolu-format-on-save-mode)
```

## Additional configuration

The package can be configured via the usual `customize-group RET fourmolu` mechanism. For example, to enable the `TypeApplications` extension by default, you can put `("--ghc-opt" "-XTypeApplications")` under the "Fourmolu Extra Args" option (`fourmolu-extra-args` elisp var).

## Notes

This package is a fork of [vyorkin/ormolu.el](https://github.com/vyorkin/ormolu.el), followed by the moral equivalent of `s/ormolu/formolu/g` plus a few other text updates (like this one).

This package is just a tiny wrapper on top of the `reformatter.el`, I mean **really tiny**, just a few lines of code.
