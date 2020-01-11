function [r1, z1] = rotateVector(r, z, alpha)
    M = [cos(alpha) -sin(alpha)
         sin(alpha)  cos(alpha)
         ];
    Point = M * [r z]';
    r1 = Point(1);
    z1 = Point(2);
end