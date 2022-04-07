<template>
  <div id="container">
    <div id="circle" @click="togglePattern()"></div>
  </div>
  <canvas ref="canvas"></canvas>
</template>

<script>
export default {
  data() {
    return {
      ctx: null,
      multiplier: 1,
      pattern: 'circles',
    };
  },
  mounted() {
    this.$refs.canvas.width = document.documentElement.clientWidth;
    this.$refs.canvas.height = document.documentElement.clientHeight;
    this.ctx = this.$refs.canvas.getContext('2d');
    this.ctx.translate(this.$refs.canvas.width / 2, this.$refs.canvas.height / 2);

    // A rough estimation of the size of the viewport, used to scale output
    const scale = Math.round((this.$refs.canvas.width + this.$refs.canvas.height) / 2);

    if (scale < 500) {
      this.multiplier = 0.25;
    } else if (scale < 1000) {
      this.multiplier = 0.75;
    }

    this.circles();
  },
  methods: {
    getColorValue() {
      return Math.floor(Math.random() * 199);
    },
    getColor(alpha1, alpha2) {
      return (
        'rgba(' +
        this.getColorValue() +
        ', ' +
        this.getColorValue() +
        ', ' +
        this.getColorValue() +
        ', 0.' +
        (Math.floor(Math.random() * alpha1) + alpha2) +
        ')'
      );
    },
    togglePattern() {
      this.ctx.save();
      this.ctx.setTransform(1, 0, 0, 1, 0, 0);
      this.ctx.clearRect(0, 0, this.$refs.canvas.width, this.$refs.canvas.height);
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
};
</script>

<style>
/*
Note that there is no Sass here, which means the sass and sass-loader packages are technically not needed
In a real project there usually is so this serves as an example
*/
body {
  margin: 0;
  padding: 0;
  overflow: hidden;
}

#container {
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  display: flex;
  flex-flow: row wrap;
  align-content: center;
  justify-content: center;
}

#circle {
  width: 25%;
  padding-bottom: 25%;
  border-radius: 100%;
  background-color: #222;
}
</style>
