
static class HexagonGrid {

  static HE_Mesh createHemesh(float startX, float startY, float hexagonRadius, int numLevels) {
    float xOff = cos(PI/6) * hexagonRadius;
    float yOff = sin(PI/6) * hexagonRadius;    

    ArrayList <PVector> centerPoints = new ArrayList <PVector> ();
    centerPoints.add(new PVector(startX, startY));
    int previousSize = 0;
    for (int j=0; j<numLevels; j++) {
      int temp = centerPoints.size();
      for (int i=centerPoints.size()-1; i>=previousSize; i--) {
        PVector p = centerPoints.get(i);
        addPoint(centerPoints, p.x + xOff*2, p.y);
        addPoint(centerPoints, p.x + xOff, p.y + yOff*3);
        addPoint(centerPoints, p.x - xOff, p.y + yOff*3);
        addPoint(centerPoints, p.x - xOff*2, p.y);
        addPoint(centerPoints, p.x - xOff, p.y - yOff*3);
        addPoint(centerPoints, p.x + xOff, p.y - yOff*3);
      }
      previousSize = temp;
    }

    float[][] hexagonCoordinates = new float[6][2];
    for (int i=0; i<6; i++) {
      float angle = PI / 3 * (i + 0.5);
      hexagonCoordinates[i][0] = cos(angle) * hexagonRadius;
      hexagonCoordinates[i][1] = sin(angle) * hexagonRadius;
    }

    float[][] vertices = new float[centerPoints.size()*6][3];
    for (int i=0; i<centerPoints.size(); i++) {
      PVector cp = centerPoints.get(i);
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

  static void addPoint(ArrayList <PVector> points, float x, float y) {
    for (PVector p : points) if (round(x)==round(p.x)&&round(y)==round(p.y)) return;
    points.add(new PVector(x, y));
  }
}

