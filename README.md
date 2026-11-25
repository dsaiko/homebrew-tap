# dsaiko/homebrew-tap

Homebrew tap for tools published from `github.com/dsaiko`. Formulas and casks are auto-generated and pushed on each project's release.

## Usage

```bash
brew tap dsaiko/tap
brew install <formula-name>
brew install --cask <cask-name>
```

Or in one line:

```bash
brew install dsaiko/tap/<formula-name>
brew install --cask dsaiko/tap/<cask-name>
```

## Available formulas

- [`edookit-mcp`](https://github.com/dsaiko/edookit-mcp) — Unofficial MCP connector for Edookit (Czech school information system)

```bash
brew install dsaiko/tap/edookit-mcp
```

## Available casks

- [`fixpoint`](https://github.com/dsaiko/fixpoint) — Agent-agnostic automation loop for writing, reviewing and fixing code with AI panels

```bash
brew install --cask dsaiko/tap/fixpoint
```

`fixpoint` ships as a cask because its binary needs the config bundle that sits beside it in the release archive; the cask installs both together.

## License

Each formula and cask is licensed under the upstream project's license. The formula and cask files themselves are MIT.
