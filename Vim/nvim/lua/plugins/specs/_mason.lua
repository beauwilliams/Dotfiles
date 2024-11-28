return {
	'williamboman/mason.nvim',
	dependencies = {
		'williamboman/mason-lspconfig.nvim', -- If you're using mason-lspconfig as well
		'WhoIsSethDaniel/mason-tool-installer.nvim', -- If you're using mason-tool-installer
	},
	config = function()
		-- Mason setup
		local mason = safe_require('mason')
		if not mason then
			return
		end

		--INSTALL: brew install gcc@11, brew install go

		--[[ local mason_tools_installer = safe_require('lua._plugins._mason-tool-installer')
        if not mason_tools_installer then
          return
        end ]]

		mason.setup({
			ui = {
				-- Whether to automatically check for new versions when opening the :Mason window.
				check_outdated_packages_on_open = true,

				-- The border to use for the UI window. Accepts same border values as |nvim_open_win()|.
				border = 'rounded',

				icons = {
					icons = {
						package_installed = '✓',
						package_pending = '➜',
						package_uninstalled = '✗',
					},
				},

				keymaps = {
					-- Keymap to expand a package
					toggle_package_expand = '<CR>',
					-- Keymap to install the package under the current cursor position
					install_package = 'i',
					-- Keymap to reinstall/update the package under the current cursor position
					update_package = 'u',
					-- Keymap to check for new version for the package under the current cursor position
					check_package_version = 'c',
					-- Keymap to update all installed packages
					update_all_packages = 'U',
					-- Keymap to check which installed packages are outdated
					check_outdated_packages = 'C',
					-- Keymap to uninstall a package
					uninstall_package = 'X',
					-- Keymap to cancel a package installation
					cancel_installation = '<C-c>',
					-- Keymap to apply language filter
					apply_language_filter = '<C-f>',
				},
			},

			-- The directory in which to install packages.
			-- install_root_dir = path.concat({ vim.fn.stdpath('data'), 'mason' }),

			pip = {
				-- These args will be added to `pip install` calls. Note that setting extra args might impact intended behavior
				-- and is not recommended.
				--
				-- Example: { "--proxy", "https://proxyserver" }
				install_args = {},
			},

			-- Controls to which degree logs are written to the log file. It's useful to set this to vim.log.levels.DEBUG when
			-- debugging issues with package installations.
			log_level = vim.log.levels.INFO,

			-- Limit for the maximum amount of packages to be installed at the same time. Once this limit is reached, any further
			-- packages that are requested to be installed will be put in a queue.
			max_concurrent_installers = 4,

			github = {
				-- The template URL to use when downloading assets from GitHub.
				-- The placeholders are the following (in order):
				-- 1. The repository (e.g. "rust-lang/rust-analyzer")
				-- 2. The release version (e.g. "v0.3.0")
				-- 3. The asset name (e.g. "rust-analyzer-v0.3.0-x86_64-unknown-linux-gnu.tar.gz")
				download_url_template = 'https://github.com/%s/releases/download/%s/%s',
			},
		})

		-- Mason tools installer setup
		local mason_tools_installer = safe_require('mason-tool-installer')
		if not mason_tools_installer then
			return
		end

		mason_tools_installer.setup({

			-- a list of all tools you want to ensure are installed upon
			-- start; they should be the names Mason uses for each tool
			ensure_installed = {
				'stylua',
				'shellcheck',
				'luacheck',
				'codespell',
				-- 'gofumpt',
				-- 'golines',
				-- 'goimports',
				-- 'goimports-reviser',
				-- 'gotests',
				-- 'golangci-lint',
				-- 'staticcheck',

				-- you can pin a tool to a particular version
				-- { 'golangci-lint', version = 'v1.47.0' },
				-- you can turn off/on auto_update per tool
				-- { 'bash-language-server', auto_update = true },

				-- 'lua-language-server',
				--'vim-language-server',
				--'editorconfig-checker',
				--'gopls',
				--'golangci-lint',
				--'gofumpt',
				--'gomodifytags',
				--'impl',
				--'json-to-struct',
				--'luacheck',
				--'misspell',
				--'revive',
				--'shellcheck',
				--'shfmt',
				--'staticcheck',
				--'vint',
			},

			-- if set to true this will check each tool for updates. If updates
			-- are available the tool will be updated. This setting does not
			-- affect :MasonToolsUpdate or :MasonToolsInstall.
			-- Default: false
			auto_update = true,

			-- automatically install / update on startup. If set to false nothing
			-- will happen on startup. You can use :MasonToolsInstall or
			-- :MasonToolsUpdate to install tools and check for updates.
			-- Default: true
			run_on_start = true,

			-- set a delay (in ms) before the installation starts. This is only
			-- effective if run_on_start is set to true.
			-- e.g.: 5000 = 5 second delay, 10000 = 10 second delay, etc...
			-- Default: 0
			start_delay = 3000, -- 3 second delay
		})

		-- Notify when Mason tools update is complete
		vim.api.nvim_create_autocmd('User', {
			pattern = 'MasonToolsUpdateCompleted',
			callback = function()
				vim.schedule(function()
					vim.notify(
						'Mason-tool-installer has finished updating packages',
						'info',
						{ title = 'Mason Tool Installer' }
					)
				end)
			end,
		})
	end,
}
