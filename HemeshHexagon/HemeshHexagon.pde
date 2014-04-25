
// HemeshHexagon example by Amnon Owed (23.04.2014)
// (for discussion purposes, not optimized for speed)
// Dependencies: Processing 2.1.2, HE_Mesh 2014 & Peasycam v2.00

import peasy.*;
PeasyCam cam;

import wblut.math.*;
import wblut.processing.*;
import wblut.hemesh.*;
import wblut.geom.*;

WB_Render render;
HE_Mesh mesh;

boolean bDrawFaces = true;
boolean bDrawEdges = true;
boolean bDrawFaceNormals = false;

void setup() {
  size(1024, 512, P3D);
  smooth(16);
  cam = new PeasyCam(this, 300);
  render = new WB_Render(this);
  mesh = HexagonGrid.createHemesh(0, 0, 10, 15);
  HEM_Extrude extrude = new HEM_Extrude();
  extrude.setRelative(true).setChamfer(0.25).setDistance(25);
  mesh.modify(extrude);
}

void draw() {
  background(225);
  perspective(PI/3, float(width)/height, 1, 10000000);
  directionalLight(255, 255, 255, 1, 1, -1);
  directionalLight(127, 127, 127, -1, -1, 1);
  if (bDrawFaces) { noStroke(); fill(255); render.drawFaces(mesh); }
  if (bDrawEdges) { noFill(); stroke(0); render.drawEdges(mesh); }
  if (bDrawFaceNormals) { stroke(0, 0, 255); render.drawFaceNormals(15, mesh); }
  drawControls();
}

void keyPressed() {
  if (key == 'f') { bDrawFaces = !bDrawFaces; }
  if (key == 'e') { bDrawEdges = !bDrawEdges; }
  if (key == 'n') { bDrawFaceNormals = !bDrawFaceNormals; }
  if (key == 's') { saveFrame("screen-######.tif"); println("Screenshot saved: " + "screen-" + nf(frameCount, 6) + ".tif"); }
}

void drawControls() {
  cam.beginHUD();
  noLights();
  fill(0);
  text("bDrawFaces (f): " + bDrawFaces, 10, 20);
  text("bDrawEdges (e): " + bDrawEdges, 10, 40);
  text("bDrawFaceNormals (n): " + bDrawFaceNormals, 10, 60);
  text("Screenshot (s)", 10, 80);
  cam.endHUD();
}

