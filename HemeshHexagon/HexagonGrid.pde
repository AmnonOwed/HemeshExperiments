
static class HexagonGrid {

  static HE_Mesh createHemesh(double startX, double startY, double hexagonRadius, int numLevels) {
    double xOff = Math.cos(Math.PI/6) * hexagonRadius;
    double yOff = Math.sin(Math.PI/6) * hexagonRadius;    

    ArrayList <WB_Point> centerPoints = new ArrayList <WB_Point> ();
    for (int y=-numLevels; y<=numLevels; y++) {
      int aY = abs(y);
      for (int x=-numLevels; x<=numLevels - aY; x++) {
        centerPoints.add(new WB_Point((2 * x + aY ) * xOff, 3 * y * yOff));
      }
    }

    double[][] hexagonCoordinates = new double[6][2];
    for (int i=0; i<6; i++) {
      double angle = Math.PI / 3 * (i + 0.5);
      hexagonCoordinates[i][0] = Math.cos(angle) * hexagonRadius;
      hexagonCoordinates[i][1] = Math.sin(angle) * hexagonRadius;
    }

    double[][] vertices = new double[centerPoints.size()*6][3];
    for (int i=0; i<centerPoints.size(); i++) {
      WB_Point cp = centerPoints.get(i);
      for (int j=0; j<6; j++) {
        int index = i*6+j;
        vertices[index][0] = cp.x + hexagonCoordinates[j][0];
        vertices[index][1] = cp.y + hexagonCoordinates[j][1];
        vertices[index][2] = 0;
      }
    }

    int[][] faces = new int[centerPoints.size()][6];
    for (int i=0; i<centerPoints.size(); i++) {
      for (int j=0; j<6; j++) {
        faces[i][j] = i*6+j;
      }
    }

    HEC_FromFacelist creator = new HEC_FromFacelist();
    creator.setVertices(vertices);
    creator.setFaces(faces);
    creator.setDuplicate(true);

    return new HE_Mesh(creator);
  }

}

