
static class HexagonGrid {

  static HE_Mesh createHemesh(double startX, double startY, double hexagonRadius, int numLevels) {
    double xOff = Math.cos(Math.PI/6) * hexagonRadius;
    double yOff = Math.sin(Math.PI/6) * hexagonRadius;    

    ArrayList <WB_Point> centerPoints = new ArrayList <WB_Point> ();
    centerPoints.add(new WB_Point(startX, startY));
    int previousSize = 0;
    for (int j=0; j<numLevels; j++) {
      int temp = centerPoints.size();
      for (int i=centerPoints.size()-1; i>=previousSize; i--) {
        WB_Point p = centerPoints.get(i);
        addPoint(centerPoints, p.x + xOff*2, p.y);
        addPoint(centerPoints, p.x + xOff, p.y + yOff*3);
        addPoint(centerPoints, p.x - xOff, p.y + yOff*3);
        addPoint(centerPoints, p.x - xOff*2, p.y);
        addPoint(centerPoints, p.x - xOff, p.y - yOff*3);
        addPoint(centerPoints, p.x + xOff, p.y - yOff*3);
      }
      previousSize = temp;
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

  static void addPoint(ArrayList <WB_Point> points, double x, double y) {
    for (WB_Point p : points) if (round((float)x)==round(p.xf())&&round((float)y)==round(p.yf())) return;
    points.add(new WB_Point(x, y));
  }
  
}

