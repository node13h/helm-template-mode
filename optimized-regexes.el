#!/usr/bin/emacs --script

;; Copyright (C) 2021 Sergej Alikov <sergej@alikov.com>

;; Author: Sergej Alikov

;; This program is free software; you can redistribute it and/or
;; modify it under the terms of the GNU General Public License
;; as published by the Free Software Foundation; either version 2
;; of the License, or (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program; if not, write to the Free Software
;; Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.

(print "Helm functions regex")
(print
 (concat "\\<"
         (regexp-opt
          (list
           "and" "or" "not" "eq" "ne" "lt" "le" "gt" "ge" "default" "empty" "fail" "coalesce" "ternary"
           "print" "println" "printf" "trim" "trimAll" "trimPrefix" "trimSuffix" "lower" "upper" "title" "untitle" "repeat" "substr" "nospace" "trunc" "abbrev" "abbrevboth" "initials" "randAlphaNum" "randAlpha" "randNumeric" "randAscii" "wrap" "wrapWith" "contains" "hasPrefix" "hasSuffix" "quote" "squote" "cat" "indent" "nindent" "replace" "plural" "snakecase" "camelcase" "kebabcase" "swapcase" "shuffle"
           "toStrings" "toDecimal" "toJson" "mustToJson" "toPrettyJson" "mustToPrettyJson" "toRawJson" "mustToRawJson"
           "regexMatch" "mustRegexMatch" "regexFindAll" "mustRegexFindAll" "regexFind" "mustRegexFind" "regexReplaceAll" "mustRegexReplaceAll" "regexReplaceAllLiteral" "mustRegexReplaceAllLiteral" "regexSplit" "mustRegexSplit"
           "sha1sum" "sha256sum" "adler32sum" "htpasswd" "derivePassword" "genPrivateKey" "buildCustomCert" "genCA" "genSelfSignedCert" "genSignedCert" "encryptAES" "decryptAES"
           "now" "ago" "date" "dateInZone" "duration" "durationRound" "unixEpoch" "dateModify" "mustDateModify" "htmlDate" "htmlDateInZone" "toDate" "mustToDate"
           "dict" "get" "set" "unset" "hasKey" "pluck" "merge" "mustMerge" "mergeOverwrite" "mustMergeOverwrite" "keys" "pick" "omit" "values" "deepCopy" "mustDeepCopy"
           "b64enc" "b64dec" "b32enc" "b32dec"
           "first" "mustFirst" "rest" "mustRest" "last" "mustLast" "initial" "mustInitial" "append" "mustAppend" "prepend" "mustPrepend" "concat" "reverse" "mustReverse" "uniq" "mustUniq" "without" "mustWithout" "has" "mustHas" "compact" "mustCompact" "slice" "mustSlice" "until" "untilStep" "seq"
           "add" "add1" "sub" "div" "mod" "mul" "max" "min" "floor" "ceil" "round" "len"
           "getHostByName"
           "base" "dir" "cleanext" "isAbs"
           "kindOf" "kindIs" "typeOf" "typeIs" "typeIsLike" "deepequal"
           "semver" "semverCompare"
           "urlParse" "urlJoin" "urlquery"
           "uuidv4"
           "lookup"
           ))
         "\\>"))

(print "Helm keywords regex")
(print
 (concat "\\<"
         (regexp-opt
          (list
           "if" "else" "with" "range" "define" "template" "block" "end"))
         "\\>"))

(print "Helm builtins regex")
(print
 (concat "\\<"
         (regexp-opt
          (list
           "include" "tpl" "required" "index" "list" "toToml" "fromJson" "fromJsonArray" "toYaml" "fromYaml" "fromYamlArray"))
         "\\>"))
