<template>
  <div id="app">
    <div id="container">
      <div id="circle" @click="togglePattern()"></div>
    </div>
    <canvas id="canvas"></canvas>
  </div>
</template>

<script>
export default {
  data() {
    return {
      canvas: null,
      ctx: null,
      multiplier: 1,
      pattern: 'circles',
    };
  },
  methods: {
    getColorValue() {
      return Math.floor(Math.random() * 199);
    },
    getColor(alpha1, alpha2) {
      return (
        "rgba(" +
        this.getColorValue() +
        ", " +
        this.getColorValue() +
        ", " +
        this.getColorValue() +
        ", 0." +
        (Math.floor(Math.random() * alpha1) + alpha2) +
        ")"
      );
    },
    togglePattern() {
      this.ctx.save();
      this.ctx.setTransform(1, 0, 0, 1, 0, 0);
      this.ctx.clearRect(0, 0, this.canvas.width, this.canvas.height);
      this.ctx.restore();
      if (this.pattern === 'circles') {
        this.pattern = 'triangles';
        this.triangles();
      } else {
        this.pattern = 'circles';
        this.circles();
      }
    },
    triangles() {
      for (let i = 8; i < 16; i += 1) {
        this.ctx.fillStyle = this.getColor(4, 2);
        this.ctx.rotate((Math.floor(Math.random() * 10) + 6) / 10);
        this.ctx.beginPath();
        this.ctx.moveTo(-30, -30);
        this.ctx.lineTo(i * 10, i * -8);
        this.ctx.lineTo(
          i * (50 * this.multiplier + i),
          i * (60 * this.multiplier - i)
        );
        this.ctx.lineTo(i * -6 * this.multiplier, i * 12 * this.multiplier);
        this.ctx.closePath();
        this.ctx.fill();
      }
    },
    circles() {
      for (let j = 2; j <= 6; j += 2) {
        for (let i = 15; i <= 30; i += 1.5) {
          this.ctx.fillStyle = this.getColor(7, 2);
          this.ctx.rotate(1.571 * i);
          this.ctx.beginPath();
          this.ctx.arc(
            0,
            j * i * 4 * this.multiplier,
            (i / j) * 8 * this.multiplier,
            0,
            Math.PI * 2,
            true
          );
          this.ctx.closePath();
          this.ctx.fill();
        }
      }
    },
  },
  mounted() {
    this.canvas = document.getElementById("canvas");
    this.canvas.width = document.documentElement.clientWidth;
    this.canvas.height = document.documentElement.clientHeight;
    this.ctx = canvas.getContext("2d");
    this.ctx.translate(this.canvas.width / 2, this.canvas.height / 2);

    // A rough estimation of the size of the viewport, used to scale output
    const scale = Math.round((this.canvas.width + this.canvas.height) / 2);

    if (scale < 500) {
      this.multiplier = 0.25;
    } else if (scale < 1000) {
      this.multiplier = 0.75;
    }

    this.circles();
  },
};
</script>
