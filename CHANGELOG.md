# Changelog

## 0.5.5

Software bill of materials: [SBOM](bom.xml).

### Security updates

| Upstream severity | Actual severity | Package | Finding | Exploitability in this service | Resolution in 0.5.5 |
|---|---|---|---|---|---|
| High | High | rack | Multipart parsing can cause denial of service through unbounded scan-buffer growth. [Advisory](https://github.com/advisories/GHSA-5v64-555j-wjxm) | Availability attack may run before API-key authorization because request parameters are parsed on the request path. Public reachability and ingress size/rate limits not reviewed. | Updated `rack` to 3.2.8 (fixed). |
| Moderate | Low | rack | `Rack::Static` header rules can be bypassed through inconsistent path-segment normalization. [Advisory](https://github.com/advisories/GHSA-wvg4-6p58-3gh3) | Requires affected static middleware to serve requests. Not evidenced in app config; production Rails static serving is disabled unless `RAILS_SERVE_STATIC_FILES` is set. External static/proxy setup not reviewed. | Updated `rack` to 3.2.8 (fixed). |
| Moderate | Low | rack | `Rack::Request#host_with_port`, `#base_url`, and `#url` return an invalid Host header unchanged; incomplete fix for CVE-2026-34835. [Advisory](https://github.com/advisories/GHSA-2j8w-xcrc-x985) | Could affect Host-based URLs or routing if middleware/downstream code trusts these values. No direct app use found; exploitation not established. | Updated `rack` to 3.2.8 (fixed). |
| Moderate | Low | actionpack | Cache poisoning in content negotiation. [Advisory](https://github.com/advisories/GHSA-r9jg-fmfx-2gv6) | Could affect shared responses if negotiated output is cached across users. App returns JSON; no response-cache setup found. Deployed shared-cache/proxy behavior not reviewed. | Updated `actionpack` to 8.1.4.1 (above stated fix 8.0.5.2). |
| Low | Low | rack | Multipart boundary validation can be bypassed with a quoted value, potentially bypassing web application firewalls. [Advisory](https://github.com/advisories/GHSA-p8x9-v4hv-2w4g) | WAF inspection bypass requires a WAF that parses multipart boundaries differently from Rack and forwards the request. WAF configuration not reviewed. | Updated `rack` to 3.2.8 (fixed). |
| Low | Low | nokogiri | Use-after-free when replacing an attribute value. [Advisory](https://github.com/advisories/GHSA-3w22-6jfg-527w) | Could affect process stability or memory safety if the mutation path is reached. No direct Nokogiri use found; transitive paths not established. | Updated `nokogiri` to 1.19.7 (fixed). |
| Low | Low | nokogiri | JRuby: `NONET` can be bypassed for external DTDs and entities when the system ID uses a short-form IPv4 address. [Advisory](https://github.com/advisories/GHSA-v995-44v6-5fqm) | Requires JRuby and the affected DTD/entity parsing path. JRuby is not listed as a lockfile platform; deployed runtime not verified. No app DTD/entity parsing found. | Updated `nokogiri` to 1.19.7 (fixed). |
| Moderate | None | activestorage | Denial of service in proxy mode caused by storage errors during streaming. [Advisory](https://github.com/advisories/GHSA-4v2w-w6g6-f8f8) | Not applicable to the current bundle: unused `activestorage` is absent from `Gemfile` and `Gemfile.lock`. Confirm deployed images use the lockfile. | Removed unused `activestorage`. |
| Moderate | None | activestorage | Possible denial of service when processing filenames. [Advisory](https://github.com/advisories/GHSA-p2pm-g2h6-7j5j) | Not applicable to the current bundle: unused `activestorage` is absent from `Gemfile` and `Gemfile.lock`. Confirm deployed images use the lockfile. | Removed unused `activestorage`. |
| Moderate | None | activestorage | File-size limits can be bypassed in direct uploads to Google Cloud Storage. [Advisory](https://github.com/advisories/GHSA-hfr4-8rjc-97m2) | Not applicable to the current bundle: unused `activestorage` is absent from `Gemfile` and `Gemfile.lock`. Confirm deployed images use the lockfile. | Removed unused `activestorage`. |
| High | None | activestorage | Arbitrary file read and remote code execution in video previews, analysis, and image processing. [Advisory](https://github.com/advisories/GHSA-v924-7rp8-4mxh) | Not applicable to the current bundle: unused `activestorage` is absent from `Gemfile` and `Gemfile.lock`. Confirm deployed images use the lockfile. | Removed unused `activestorage`. |
| Low | None | actionmailbox | Signature replay in Mailgun ingress. [Advisory](https://github.com/advisories/GHSA-5957-c7qm-m469) | Not applicable to the current bundle: unused `actionmailbox` is absent from `Gemfile` and `Gemfile.lock`; no Mailgun ingress is configured in the app. Confirm deployed images use the lockfile. | Removed unused `actionmailbox`. |
| Low | None | nokogiri | Mutation XSS through `noscript` content in the HTML5 serializer. [Advisory](https://github.com/advisories/GHSA-4p39-36wj-23h4) | No app use of Nokogiri's HTML5 serializer found; endpoints return JSON. No exploitation path identified in the repository. | Updated `nokogiri` to 1.19.7 (fixed). |
| Moderate | None | actionpack | Destroyed sessions may be restored in the `ActionDispatch` CacheStore. [Advisory](https://github.com/advisories/GHSA-2586-8ghr-69fj) | No session use or session-store configuration found; app uses `ActionController::API`. No exploitation path identified in the repository. | Updated `actionpack` to 8.1.4.1 (above stated fix 8.0.5.2). |
| Low | None | actionpack | Missing SameSite attribute on session cookies from certain Action Pack session stores. [Advisory](https://github.com/advisories/GHSA-gmj8-hvj3-49mw) | No session or cookie use found; app uses `ActionController::API`. No exploitation path identified in the repository. | Updated `actionpack` to 8.1.4.1 (above stated fix 8.0.5.2). |

### Runtime

Ruby updated from 3.3.10 to 3.4.12 in `.ruby-version`, `Gemfile`, and `Gemfile.lock`.

| CVE | Fixed component/version | App exposure |
|---|---|---|
| [CVE-2026-27820](https://www.cve.org/CVERecord?id=CVE-2026-27820) | Ruby 3.4.9+ fixes the `Zlib::GzipReader` buffer overflow; target is 3.4.12. | No explicit `Zlib::GzipReader` use found; transitive paths not assessed. |
| [CVE-2026-41316](https://www.cve.org/CVERecord?id=CVE-2026-41316) | `erb` fixed in 4.0.3.1+; lockfile has 6.0.7. | App uses `Erubis`; no attacker-controlled ERB deserialization path found. |
| [CVE-2026-80212](https://www.cve.org/CVERecord?id=CVE-2026-80212) | `resolv` fixed in 0.7.2; current Ruby runtime reports default gem 0.7.2. | No direct `Resolv` use found. `resolv` is not locked; verify deployed Ruby image has 0.7.2+. |
| [CVE-2026-80213](https://www.cve.org/CVERecord?id=CVE-2026-80213) | `resolv` fixed in 0.7.2; current Ruby runtime reports default gem 0.7.2. | No hostname-allowlist-then-Resolv path found. `resolv` is not locked; verify deployed Ruby image has 0.7.2+. |
| [CVE-2026-89078](https://www.cve.org/CVERecord?id=CVE-2026-89078) | Ruby 3.4.12 fixes the Regexp parser double-free. | No attacker-controlled pattern compilation found; app uses static regex literals. |
| [CVE-2026-93577](https://www.cve.org/CVERecord?id=CVE-2026-93577) | Ruby 3.4.12 fixes integer overflow in compiled pattern size. | No attacker-controlled pattern compilation found. |
| [CVE-2026-97229](https://www.cve.org/CVERecord?id=CVE-2026-97229) | Ruby 3.4.12 fixes integer overflow in CI/CD Regexp compilation. | No attacker-controlled pattern compilation found. |
| [CVE-2026-110264](https://www.cve.org/CVERecord?id=CVE-2026-110264) | Ruby 3.4.12 fixes overflow of internal IDs in repeated patterns. | No attacker-controlled pattern compilation found. |

Not counted as newly fixed: CVE-2025-61594 was already in the Ruby 3.3.10 baseline; CVE-2022-28738 and CVE-2024-27282 are historical references in the Regexp advisory. `net-imap` CVEs from `ruby-cves.txt` are outside the app bundle (`net-imap` is absent from `Gemfile.lock`). CVE-2026-46727 is linked only to Ruby 4.0.5 in the report; no Ruby 3.4.12 fix is established.
