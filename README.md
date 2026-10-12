# Ph&omacr;st

This is Alexander Nicholi&rsquo;s hotography post-processing workflow.

The Sony&reg; &alpha;7R IV produces Sony RAW images (`.arw`) that are
post-produced in either Sony&rsquo;s [Imaging Edge Desktop][1] program,
or alternatively in Adobe&reg; Lightroom&trade; (Alexander does not use
Adobe products anymore). Imaging Edge Desktop can export a deep colour
TIFF file, which is converted without information loss into a deep
colour PNG using ImageMagick. This PNG is then fed into [Guetzli][2] to
make an extremely high-quality full resolution JPEG.

Guetzli is a memory-hard program and for &alpha;7R-created photographs
consumes about 16GiB of RAM per process. This is the deciding factor to
consider when specifying the degree of parallelism to Make via the `-j`
flag; for example, a machine with 64GiB of RAM can handle `-j3`, while
128GiB of RAM allows for `-j7`, leaving a bit for the rest of the system
to use during the run.

The Makefile was created to cope with the tediousness of opening several
terminal windows and babying the processes in succession.
Guetzli&rsquo;s runtime can vary greatly depending on the
characteristics of the input image; for this reason, dumb batching can
lead to considerable resource waste as certain images take longer to
complete than others.

The best way to use the Makefile is as follows:

```sh
make -f $PHOST_DIR/Makefile FILES=$your_file_list
```

Alternatively, `make` can be run ragged by symlinking the folder
containing all the input files under the local name `files/` and then
giving `$(FILES)` as a list of `$PWD`-relative paths to the files.

`$(FILES)` may contain a list of PNGs and/or TIFF files. Mixing PNGs and
TIFFs is permitted; TIFFs will be processed into PNGs as an intermediate
step while PNGs&mdash;regardless of source&mdash;will then be processed
into JPEGs using Guetzli.

---

This program is free software; you can redistribute it and/or modify it
under the terms of the GNU General Public License as published by the
Free Software Foundation.

This program is distributed in the hope that it will be useful, but
WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
General Public License for more details.

You should have received a copy of the GNU General Public License along
with this program; if not, write to the Free Software Foundation, Inc.,
51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.

[1]: https://creatorscloud.sony.net/catalog/en-gb/ie-desktop/index.html
[2]: https://github.com/google/guetzli
