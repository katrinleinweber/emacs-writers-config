;;; org-brain-autoloads.el --- automatically extracted autoloads
;;
;;; Code:
(add-to-list 'load-path (directory-file-name (or (file-name-directory #$) (car load-path))))

;;;### (autoloads nil "org-brain" "org-brain.el" (23065 44079 704154
;;;;;;  932000))
;;; Generated autoloads from org-brain.el

(autoload 'org-brain-update-id-locations "org-brain" "\
Scan `org-brain-files' using `org-id-update-id-locations'.

\(fn)" t nil)

(autoload 'org-brain-add-child "org-brain" "\
Add external child to entry at point.
If chosen child entry doesn't exist, create it as a new file.
Several children can be added, by using `org-brain-entry-separator'.

\(fn)" t nil)

(autoload 'org-brain-new-child "org-brain" "\
Create a new internal child headline to entry at point.
Several children can be created, by using `org-brain-entry-separator'.

\(fn)" t nil)

(autoload 'org-brain-remove-child "org-brain" "\
Remove child from entry at point.

\(fn)" t nil)

(autoload 'org-brain-add-parent "org-brain" "\
Add external parent to entry at point.
If chosen parent entry doesn't exist, create it as a new file.
Several parents can be added, by using `org-brain-entry-separator'.

\(fn)" t nil)

(autoload 'org-brain-remove-parent "org-brain" "\
Remove external parent from entry at point.

\(fn)" t nil)

(autoload 'org-brain-add-friendship "org-brain" "\
Add a new friend to entry at point.
If chosen friend entry doesn't exist, create it as a new file.
Several friends can be added, by using `org-brain-entry-separator'.

\(fn)" t nil)

(autoload 'org-brain-remove-friendship "org-brain" "\
Remove friendship between ENTRY1 and ENTRY2.
If ONEWAY is t, then remove ENTRY2 as a friend of ENTRY1, but not vice versa.

If run interactively, use `org-brain-entry-at-pt' as ENTRY1 and prompt for ENTRY2.

\(fn ENTRY1 ENTRY2 &optional ONEWAY)" t nil)

(autoload 'org-brain-goto "org-brain" "\
Goto buffer and position of org-brain ENTRY.
If ENTRY isn't specified, ask for the ENTRY.

\(fn &optional ENTRY)" t nil)

(autoload 'org-brain-goto-end "org-brain" "\
Like `org-brain-goto', but visits the end of ENTRY.
If ENTRY isn't specified, ask for the ENTRY.

\(fn &optional ENTRY)" t nil)

(autoload 'org-brain-goto-current "org-brain" "\
Use `org-brain-goto' on `org-brain-entry-at-pt'.

\(fn)" t nil)

(autoload 'org-brain-goto-child "org-brain" "\
Goto a child of ENTRY.
If run interactively, get ENTRY from context.
If ALL is nil, choose only between externally linked children.

\(fn ENTRY &optional ALL)" t nil)

(autoload 'org-brain-goto-parent "org-brain" "\
Goto a parent of ENTRY.
If run interactively, get ENTRY from context.
If ALL is nil, choose only between externally linked parents.

\(fn ENTRY &optional ALL)" t nil)

(autoload 'org-brain-goto-friend "org-brain" "\
Goto a friend of ENTRY.
If run interactively, get ENTRY from context.

\(fn ENTRY)" t nil)

(autoload 'org-brain-delete-entry "org-brain" "\
Delete ENTRY and all of its local children.
If run interactively, ask for the ENTRY.
If NOCONFIRM is nil, ask if we really want to delete.

\(fn ENTRY &optional NOCONFIRM)" t nil)

(autoload 'org-brain-pin "org-brain" "\
Change if ENTRY is pinned or not.
If run interactively, get ENTRY from context.

If STATUS is positive, pin the entry. If negative, remove the pin.
If STATUS is omitted, toggle between pinned / not pinned.

\(fn ENTRY &optional STATUS)" t nil)

(autoload 'org-brain-set-title "org-brain" "\
Set the name of ENTRY to TITLE.
If run interactively, get ENTRY from context and prompt for TITLE.

\(fn ENTRY TITLE)" t nil)

(autoload 'org-brain-set-tags "org-brain" "\
Use `org-set-tags' on headline ENTRY.
If run interactively, get ENTRY from context.

\(fn ENTRY)" t nil)

(autoload 'org-brain-headline-to-file "org-brain" "\
Convert headline ENTRY to a file entry.
Prompt for name of the new file.
If interactive, also prompt for ENTRY.

\(fn ENTRY)" t nil)

(autoload 'org-brain-insert-link "org-brain" "\
Insert a link to an org-brain entry and suggest a description.
Adds the linked entry as a child if `org-brain-brain-link-adds-child' is t.

\(fn)" t nil)

(autoload 'org-brain-agenda "org-brain" "\
Like `org-agenda', but only for `org-brain-files'.

\(fn)" t nil)

(autoload 'org-brain-create-relationships-from-links "org-brain" "\
Add relationships for brain: links in `org-brain-path'.
Only create relationships to other files, not to headline entries.

This function is meant to be used in order to convert old
org-brain setups to the system introduced in version 0.4. Please
make a backup of your `org-brain-path' before running this
function.

\(fn)" t nil)

(autoload 'org-brain-visualize "org-brain" "\
View a concept map with ENTRY at the center.

When run interactively, prompt for ENTRY and suggest
`org-brain-entry-at-pt'. By default, the choices presented is
determined by `org-brain-visualize-default-choices': 'all will
show all entries, 'files will only show file entries and 'root
will only show files in the root of `org-brain-path'.

You can override `org-brain-visualize-default-choices':
  `\\[universal-argument]' will use 'all.
  `\\[universal-argument] \\[universal-argument]' will use 'files.
  `\\[universal-argument] \\[universal-argument] \\[universal-argument]' will use 'root.

Unless NOFOCUS is non-nil, the `org-brain-visualize' buffer will gain focus.
Unless NOHISTORY is non-nil, add the entry to `org-brain--vis-history'.
Setting NOFOCUS to t implies also having NOHISTORY as t.
Unless WANDER is t, `org-brain-stop-wandering' will be run.

\(fn ENTRY &optional NOFOCUS NOHISTORY WANDER)" t nil)

(autoload 'org-brain-visualize-random "org-brain" "\
Run `org-brain-visualize' on a random org-brain entry.

\(fn)" t nil)

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; End:
;;; org-brain-autoloads.el ends here
