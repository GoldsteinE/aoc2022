#include <stdio.h>
#include <stdint.h>
#include <string.h>

#include "main.h"

#define FORMAT "Sensor at x=%ld, y=%ld: closest beacon is at x=%ld, y=%ld\n"

int main(int argc, char** argv) {
	int part = 1;
	int64_t line = 10;
	if (argc == 3) {
		if (strcmp(argv[1], "demo") != 0) {
			line = 2000000L;
		}
		if (strcmp(argv[2], "1") != 0) {
			part = 2;
		}
	}

	int64_t sensors[64 * 4];
	ssize_t n = 0;
	int64_t sx, sy, bx, by;
	for (; scanf(FORMAT, &sx, &sy, &bx, &by) != EOF; n++) {
		sensors[n * 4 + 0] = sx;
		sensors[n * 4 + 1] = sy;
		sensors[n * 4 + 2] = bx;
		sensors[n * 4 + 3] = by;
	}

	struct futhark_context_config* conf = futhark_context_config_new();
	struct futhark_context* ctx = futhark_context_new(conf);
	struct futhark_i64_2d* input = futhark_new_i64_2d(ctx, sensors, n, 4);
	int64_t out;
	if (part == 1) {
		if (futhark_entry_part1_exported(ctx, &out, input, line)) {
			fprintf(stderr, "Futhark returned error: %s", futhark_context_get_error(ctx));
			return 1;
		}
	} else {
		if (futhark_entry_part2_exported(ctx, &out, input, line * 2)) {
			fprintf(stderr, "Futhark returned error: %s", futhark_context_get_error(ctx));
			return 1;
		}
	}
	futhark_context_sync(ctx);
	printf("%ld\n", out);
}
