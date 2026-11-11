# Changelog

## 0.5.5

Software bill of materials: [SBOM](bom.xml).

### Security updates

The following vulnerabilities are fixed:

| CVE/GHSA | Actual severity | Exploitability in this service |
|---|---|---|
| [GHSA-5v64-555j-wjxm](https://github.com/advisories/GHSA-5v64-555j-wjxm) | High | An unauthenticated multipart request could trigger unbounded Rack scan-buffer growth before API-key authorization, exhausting process memory. |
| [GHSA-wvg4-6p58-3gh3](https://github.com/advisories/GHSA-wvg4-6p58-3gh3) | Low | A crafted dot-segment path could bypass `Rack::Static` header rules if that middleware served the request. App config does not enable it; external static/proxy setup is unknown. |
| [GHSA-2j8w-xcrc-x985](https://github.com/advisories/GHSA-2j8w-xcrc-x985) | Low | An invalid Host header could be returned unchanged by Rack URL helpers; downstream code trusting those values could build attacker-controlled URLs or routing decisions. No direct app use found. |
| [GHSA-r9jg-fmfx-2gv6](https://github.com/advisories/GHSA-r9jg-fmfx-2gv6) | Low | Crafted content-negotiation headers could poison a shared cache if negotiated responses were cached across users. App returns JSON; external cache behavior is unknown. |
| [GHSA-p8x9-v4hv-2w4g](https://github.com/advisories/GHSA-p8x9-v4hv-2w4g) | Low | A quoted multipart boundary could make Rack and a WAF parse the body differently, bypassing WAF inspection. Requires a mismatched, forwarding WAF. |
| [GHSA-3w22-6jfg-527w](https://github.com/advisories/GHSA-3w22-6jfg-527w) | Low | Attacker-controlled content reaching the affected attribute-replacement path could trigger use-after-free and process memory corruption. No direct Nokogiri path found. |
| [GHSA-v995-44v6-5fqm](https://github.com/advisories/GHSA-v995-44v6-5fqm) | None | On JRuby, a short-form IPv4 system ID in external DTD/entity input could bypass `NONET`. This app targets MRI and has no such parser path. |
| [GHSA-4v2w-w6g6-f8f8](https://github.com/advisories/GHSA-4v2w-w6g6-f8f8) | None | Unused `activestorage` dependency; no proxy-streaming path in this app; dependency removed. |
| [GHSA-p2pm-g2h6-7j5j](https://github.com/advisories/GHSA-p2pm-g2h6-7j5j) | None | Unused `activestorage` dependency; no filename-processing path in this app; dependency removed. |
| [GHSA-hfr4-8rjc-97m2](https://github.com/advisories/GHSA-hfr4-8rjc-97m2) | None | Unused `activestorage` dependency; no direct-upload path in this app; dependency removed. |
| [GHSA-v924-7rp8-4mxh](https://github.com/advisories/GHSA-v924-7rp8-4mxh) | None | Unused `activestorage` dependency; no preview/analysis path in this app; dependency removed. |
| [GHSA-5957-c7qm-m469](https://github.com/advisories/GHSA-5957-c7qm-m469) | None | Unused `actionmailbox` dependency; no Mailgun ingress in this app; dependency removed. |
| [GHSA-4p39-36wj-23h4](https://github.com/advisories/GHSA-4p39-36wj-23h4) | None | Attacker-controlled `noscript` HTML serialized by Nokogiri's HTML5 serializer could produce mutation XSS. App returns JSON and has no such serialization/render path. |
| [GHSA-2586-8ghr-69fj](https://github.com/advisories/GHSA-2586-8ghr-69fj) | None | A client could exploit the affected CacheStore session flow to restore a destroyed session. This API app does not use sessions or that store. |
| [GHSA-gmj8-hvj3-49mw](https://github.com/advisories/GHSA-gmj8-hvj3-49mw) | None | Cross-site requests could carry session cookies lacking `SameSite` when using affected stores. This API app has no session-cookie flow. |

### Runtime

Ruby updated from 3.3.10 to 3.4.12 in `.ruby-version`, `Gemfile`, and `Gemfile.lock`.

The following vulnerabilities are fixed:

| CVE/GHSA | Actual severity | Exploitability in this service |
|---|---|---|
| [CVE-2026-27820](https://www.cve.org/CVERecord?id=CVE-2026-27820) | Low | Attacker-controlled gzip input reaching `Zlib::GzipReader` could trigger a buffer overflow. No explicit use found; transitive paths not assessed. |
| [CVE-2026-80212](https://www.cve.org/CVERecord?id=CVE-2026-80212) | Low | Repeated `Resolv` lookups against attacker-controlled DNS responses could grow memory without bound. No direct call found; deployed default-gem version must match. |
| [CVE-2026-41316](https://www.cve.org/CVERecord?id=CVE-2026-41316) | None | Crafted deserialized ERB objects could bypass the `_init` guard through `def_module`/`def_method`/`def_class`. App uses `Erubis`, not this ERB path. |
| [CVE-2026-80213](https://www.cve.org/CVERecord?id=CVE-2026-80213) | None | An overlong hostname could pass validation then resolve to a different host through `Resolv`, bypassing an allowlist/SSRF check. No such app flow found. |
| [CVE-2026-89078](https://www.cve.org/CVERecord?id=CVE-2026-89078) | None | Compiling a crafted attacker-controlled regex could trigger a double-free. App compiles only static regex literals. |
| [CVE-2026-93577](https://www.cve.org/CVERecord?id=CVE-2026-93577) | None | Compiling a crafted attacker-controlled regex could overflow the compiled-pattern size. App compiles only static regex literals. |
| [CVE-2026-97229](https://www.cve.org/CVERecord?id=CVE-2026-97229) | None | Crafted CI/CD regex compilation could trigger integer overflow. App has no user-controlled regex compilation path. |
| [CVE-2026-110264](https://www.cve.org/CVERecord?id=CVE-2026-110264) | None | Compiling a crafted repeated-pattern regex could overflow internal IDs. App compiles only static regex literals. |

Not counted as newly fixed: CVE-2025-61594 was already in the Ruby 3.3.10 baseline; CVE-2022-28738 and CVE-2024-27282 are historical references in the Regexp advisory.
