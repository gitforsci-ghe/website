# Build-up drawings for the Git for Scientists workshop slides.
#
# Each concept (local/remote, commit cycle, branching, pull request) is drawn
# as a cumulative sequence of frames named drawing-N-<name>-00.png .. -NN.png.
# Every later frame is the previous frame plus one more element, so the slides
# reveal them one per key press (via reveal.js .r-stack + .fragment) and the
# picture grows one element at a time.
#
# Hand-drawn Excalidraw-like look: wobbly strokes, Comic Sans, a warm sketch
# palette. These are generated placeholders that match the storyboards in the
# GitHub issues; replace with real Excalidraw exports at identical canvas size
# whenever preferred.

set.seed(42)

out_dir <- "workshop/images"

# palette (Excalidraw-ish)
col_ink    <- "#1e1e1e"
col_blue   <- "#1971c2"
col_green  <- "#2f9e44"
col_orange <- "#e8590c"
col_violet <- "#7048e8"
col_fill_b <- "#a5d8ff"
col_fill_g <- "#b2f2bb"
col_fill_y <- "#ffec99"
col_fill_v <- "#d0bfff"
col_paper  <- "#ffffff"

W <- 1600L
H <- 1000L

# a slightly wobbly line, so strokes look hand-drawn
wobble <- function(x0, y0, x1, y1, col = col_ink, lwd = 4, n = 24, amp = 2.2) {
  t <- seq(0, 1, length.out = n)
  x <- x0 + (x1 - x0) * t + rnorm(n, 0, amp)
  y <- y0 + (y1 - y0) * t + rnorm(n, 0, amp)
  x[1] <- x0; y[1] <- y0; x[n] <- x1; y[n] <- y1
  lines(x, y, col = col, lwd = lwd, lend = 1, ljoin = 1)
}

# a wobbly rectangle with a soft fill
sketch_box <- function(xc, yc, w, h, fill = col_fill_b, border = col_blue, lwd = 4) {
  x0 <- xc - w/2; x1 <- xc + w/2; y0 <- yc - h/2; y1 <- yc + h/2
  polygon(c(x0, x1, x1, x0), c(y0, y0, y1, y1),
          col = fill, border = NA)
  wobble(x0, y0, x1, y0, border, lwd); wobble(x1, y0, x1, y1, border, lwd)
  wobble(x1, y1, x0, y1, border, lwd); wobble(x0, y1, x0, y0, border, lwd)
}

sketch_text <- function(x, y, label, cex = 2.1, col = col_ink, font = 1) {
  text(x, y, label, cex = cex, col = col, font = font, family = "Comic Sans MS")
}

# a wobbly arrow with a small head
sketch_arrow <- function(x0, y0, x1, y1, col = col_ink, lwd = 5, label = NULL,
                         lab_dy = 34, curve = 0) {
  # optional slight arc so parallel arrows do not overlap
  mx <- (x0 + x1)/2 + curve
  my <- (y0 + y1)/2 + curve * 0.2
  t <- seq(0, 1, length.out = 30)
  x <- (1-t)^2 * x0 + 2*(1-t)*t*mx + t^2*x1 + rnorm(30, 0, 1.4)
  y <- (1-t)^2 * y0 + 2*(1-t)*t*my + t^2*y1 + rnorm(30, 0, 1.4)
  lines(x, y, col = col, lwd = lwd, lend = 1)
  # arrowhead
  ang <- atan2(y1 - y[28], x1 - x[28])
  hl <- 26
  for (a in c(ang + 2.7, ang - 2.7))
    wobble(x1, y1, x1 - hl*cos(a), y1 - hl*sin(a), col, lwd, n = 8, amp = 1)
  if (!is.null(label))
    sketch_text(mx, my + lab_dy, label, cex = 1.7, col = col, font = 2)
}

# clean (non-wobbly) helpers, used where a tidy diagram reads better than a sketch

# a rounded rectangle with straight edges
clean_box <- function(xc, yc, w, h, fill = col_fill_b, border = col_blue, lwd = 5) {
  x0 <- xc - w/2; x1 <- xc + w/2; y0 <- yc - h/2; y1 <- yc + h/2
  r  <- 26
  # rounded corners via a polygon with arc segments
  arc <- function(cx, cy, a0, a1) {
    a <- seq(a0, a1, length.out = 12)
    cbind(cx + r*cos(a), cy + r*sin(a))
  }
  pts <- rbind(
    arc(x1 - r, y0 + r, -pi/2, 0),
    arc(x1 - r, y1 - r, 0, pi/2),
    arc(x0 + r, y1 - r, pi/2, pi),
    arc(x0 + r, y0 + r, pi, 3*pi/2)
  )
  polygon(pts[,1], pts[,2], col = fill, border = border, lwd = lwd)
}

# a cloud shape (overlapping circles) for the remote
clean_cloud <- function(xc, yc, s = 1, fill = col_fill_g, border = col_green, lwd = 5) {
  bumps <- list(c(-150, -10, 78), c(-70, 40, 92), c(30, 48, 96),
                c(120, 22, 82), c(150, -18, 70), c(0, -34, 120))
  for (b in bumps) {
    a <- seq(0, 2*pi, length.out = 60)
    polygon(xc + b[1]*s + b[3]*s*cos(a), yc + b[2]*s + b[3]*s*sin(a),
            col = fill, border = NA)
  }
  # single outline pass on the union silhouette (approximate with the outer bumps)
  for (b in bumps) {
    a <- seq(0, 2*pi, length.out = 60)
    lines(xc + b[1]*s + b[3]*s*cos(a), yc + b[2]*s + b[3]*s*sin(a),
          col = fill, lwd = 1)
  }
  # a clean base line + top arcs to suggest a cloud edge
  a <- seq(0, 2*pi, length.out = 200)
  # redraw outer bumps' borders only on top
  for (b in bumps[1:5]) {
    aa <- seq(0.05*pi, 0.95*pi, length.out = 40)
    lines(xc + b[1]*s + b[3]*s*cos(aa), yc + b[2]*s + b[3]*s*sin(aa),
          col = border, lwd = lwd)
  }
}

# a straight arrow with a filled head
clean_arrow <- function(x0, y0, x1, y1, col = col_ink, lwd = 6, label = NULL,
                        lab_side = 1) {
  lines(c(x0, x1), c(y0, y1), col = col, lwd = lwd, lend = 1)
  ang <- atan2(y1 - y0, x1 - x0); hl <- 34; hw <- 0.42
  polygon(c(x1, x1 - hl*cos(ang - hw), x1 - hl*cos(ang + hw)),
          c(y1, y1 - hl*sin(ang - hw), y1 - hl*sin(ang + hw)),
          col = col, border = col)
  if (!is.null(label)) {
    mx <- (x0 + x1)/2; my <- (y0 + y1)/2
    text(mx + 46*lab_side, my, label, cex = 1.6, col = col, font = 2,
         family = "Comic Sans MS")
  }
}

open_frame <- function(path) {
  ragg::agg_png(path, width = W, height = H, background = col_paper, res = 150)
  par(mar = c(0,0,0,0))
  plot.int <- plot(NA, xlim = c(0, W), ylim = c(0, H), axes = FALSE,
                   xlab = "", ylab = "", asp = 1)
}
close_frame <- function() dev.off()

save_frames <- function(base, draw_steps) {
  # draw_steps: list of functions; frame k draws steps 1..k+1 cumulatively
  for (k in seq_along(draw_steps)) {
    path <- file.path(out_dir, sprintf("%s-%02d.png", base, k - 1))
    open_frame(path)
    set.seed(42)                      # same wobble across frames = stable overlay
    for (j in seq_len(k)) draw_steps[[j]]()
    close_frame()
    message("wrote ", path)
  }
}

# ---- Drawing 1: local and remote -----------------------------------------
# remote (cloud) on top, local (box) below; clean straight directed arrows.
cx <- 800; ry <- 780; ly <- 250   # remote top, local bottom
save_frames("drawing-1-local-remote", list(
  function() {                                   # 00 remote (cloud) on top
    clean_cloud(cx, ry, s = 1, fill = col_fill_g, border = col_green)
    text(cx, ry + 6, "remote", cex = 2.3, font = 1, family = "Comic Sans MS")
    text(cx, ry - 58, "GitHub", cex = 1.5, col = col_green, family = "Comic Sans MS")
  },
  function() {                                   # 01 local (box) below
    clean_box(cx, ly, 420, 180, col_fill_b, col_blue)
    text(cx, ly + 12, "local", cex = 2.3, family = "Comic Sans MS")
    text(cx, ly - 46, "your laptop", cex = 1.5, col = col_blue, family = "Comic Sans MS")
  },
  function()                                     # 02 clone: remote -> local
    clean_arrow(cx - 250, ry - 90, cx - 250, ly + 100, col_violet,
                label = "clone", lab_side = -1.6),
  function() {                                   # 03 push (up) and pull (down)
    clean_arrow(cx + 170, ly + 100, cx + 170, ry - 90, col_orange,
                label = "push", lab_side = 1.4)
    clean_arrow(cx + 320, ry - 90, cx + 320, ly + 100, col_blue,
                label = "pull", lab_side = 1.4)
  }
))

# ---- Drawing 2: the commit cycle -----------------------------------------
save_frames("drawing-2-commit-cycle", list(
  function() {                                   # 00 working files
    sketch_box(300, 720, 320, 170, col_fill_b, col_blue)
    sketch_text(300, 720, "working\nfiles")
  },
  function() {                                   # 01 stage
    sketch_box(760, 720, 300, 170, col_fill_y, col_orange)
    sketch_text(760, 720, "staged")
    sketch_arrow(470, 720, 600, 720, col_ink, label = "stage")
  },
  function() {                                   # 02 first commit on history line
    wobble(230, 360, 1380, 360, col_ink, 5)      # history line
    points(560, 360, pch = 19, cex = 3, col = col_green)
    sketch_arrow(760, 640, 590, 400, col_ink, label = "commit", lab_dy = 0)
    sketch_text(560, 300, "snapshot", cex = 1.5, col = col_green)
  },
  function() {                                   # 03 second commit
    points(880, 360, pch = 19, cex = 3, col = col_green)
    wobble(575, 360, 866, 360, col_green, 4)
  },
  function() {                                   # 04 push to remote
    sketch_box(1230, 360, 260, 150, col_fill_g, col_green)
    sketch_text(1230, 360, "remote", cex = 1.7)
    sketch_arrow(900, 360, 1095, 360, col_orange, label = "push", lab_dy = -40)
  }
))

# ---- Drawing 3: branching -------------------------------------------------
save_frames("drawing-3-branching", list(
  function() {                                   # 00 main line
    wobble(220, 400, 1380, 400, col_ink, 5)
    points(c(430, 640), c(400, 400), pch = 19, cex = 3, col = col_blue)
    sketch_text(250, 340, "main", cex = 1.8, col = col_blue)
  },
  function() {                                   # 01 branch splits off
    wobble(640, 400, 840, 620, col_violet, 5)
    points(840, 620, pch = 19, cex = 3, col = col_violet)
    sketch_text(1000, 660, "dev branch", cex = 1.8, col = col_violet)
  },
  function() {                                   # 02 commits on branch
    wobble(840, 620, 1080, 620, col_violet, 5)
    points(1080, 620, pch = 19, cex = 3, col = col_violet)
  },
  function() {                                   # 03 merge point left empty
    wobble(1080, 620, 1240, 430, col_violet, 4, amp = 1.4)
    points(1240, 400, pch = 1, cex = 3.4, col = col_orange, lwd = 4)
    sketch_text(1240, 330, "merge?", cex = 1.6, col = col_orange, font = 2)
  }
))

# ---- Drawing 4: the pull request -----------------------------------------
save_frames("drawing-4-pull-request", list(
  function() {                                   # 00 open merge point (from d3)
    wobble(220, 400, 1380, 400, col_ink, 5)
    points(c(430, 640), c(400, 400), pch = 19, cex = 3, col = col_blue)
    sketch_text(250, 340, "main", cex = 1.8, col = col_blue)
    wobble(640, 400, 900, 620, col_violet, 5)
    points(c(900, 1080), c(620, 620), pch = 19, cex = 3, col = col_violet)
    wobble(900, 620, 1080, 620, col_violet, 5)
    sketch_text(990, 690, "dev", cex = 1.7, col = col_violet)
    points(1240, 400, pch = 1, cex = 3.4, col = col_orange, lwd = 4)
  },
  function() {                                   # 01 pull request opened
    wobble(1080, 620, 1240, 430, col_violet, 4, amp = 1.4)
    sketch_box(760, 210, 420, 130, col_fill_v, col_violet)
    sketch_text(760, 210, "pull request", cex = 1.8, col = col_violet)
    sketch_arrow(760, 275, 1150, 400, col_violet, lwd = 4)
  },
  function() {                                   # 02 human review at the join
    points(1240, 400, pch = 19, cex = 2, col = col_orange)
    sketch_text(1240, 320, "review", cex = 1.7, col = col_orange, font = 2)
    sketch_text(1240, 285, "(a human)", cex = 1.3, col = col_orange)
  },
  function() {                                   # 03 merged, lines meet
    wobble(1240, 400, 1380, 400, col_green, 6)
    sketch_text(1330, 340, "merged", cex = 1.6, col = col_green, font = 2)
  }
))

message("done")

# ---- placeholders for hand-supplied images -------------------------------
# lars-sit-back.png and arti-persona.png are supplied by Lars later; render
# clearly-labelled placeholders so the deck builds in the meantime.
placeholder <- function(path, title, subtitle, w = 900L, h = 1100L,
                        border = col_blue, fill = "#f1f3f5") {
  ragg::agg_png(path, width = w, height = h, background = col_paper, res = 150)
  par(mar = c(0,0,0,0))
  plot(NA, xlim = c(0, w), ylim = c(0, h), axes = FALSE, xlab = "", ylab = "", asp = 1)
  set.seed(7)
  x0 <- 60; x1 <- w - 60; y0 <- 60; y1 <- h - 60
  polygon(c(x0,x1,x1,x0), c(y0,y0,y1,y1), col = fill, border = NA)
  # dashed hand-drawn border
  for (s in seq(x0, x1, by = 46)) wobble(s, y0, min(s+30, x1), y0, border, 3, n=6, amp=1)
  for (s in seq(x0, x1, by = 46)) wobble(s, y1, min(s+30, x1), y1, border, 3, n=6, amp=1)
  for (s in seq(y0, y1, by = 46)) wobble(x0, s, x0, min(s+30, y1), border, 3, n=6, amp=1)
  for (s in seq(y0, y1, by = 46)) wobble(x1, s, x1, min(s+30, y1), border, 3, n=6, amp=1)
  text(w/2, h/2 + 60, title, cex = 2.4, col = border, font = 2, family = "Comic Sans MS")
  text(w/2, h/2 - 30, subtitle, cex = 1.5, col = col_ink, family = "Comic Sans MS")
  text(w/2, h/2 - 110, "placeholder", cex = 1.3, col = "#868e96", family = "Comic Sans MS")
  dev.off()
  message("wrote ", path)
}

placeholder(file.path(out_dir, "lars-sit-back.png"),
            "instructor photo", "sit back and watch", w = 900L, h = 1000L,
            border = col_blue)
placeholder(file.path(out_dir, "arti-persona.png"),
            "Arti", "the focus learner", w = 800L, h = 1000L,
            border = col_violet, fill = "#f3f0ff")
