within Buildings;
package Rooms "Package with models for rooms"
  extends Modelica.Icons.Package;


annotation (
preferredView="info", Documentation(info="<html>
<p>
This package contains models for the heat transfer in rooms
and through the building envelope. 
</html>"),
  Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
      graphics={
      Rectangle(
        extent={{-76,42},{76,-80}},
        lineColor={150,150,150},
        fillPattern=FillPattern.Solid,
        fillColor={150,150,150}),
      Polygon(
        points={{-2,92},{-92,42},{88,42},{-2,92}},
        lineColor={95,95,95},
        smooth=Smooth.None,
        fillPattern=FillPattern.Solid,
        fillColor={95,95,95}),
      Rectangle(
        extent={{16,-8},{44,20}},
        lineColor={255,255,255},
        fillColor={255,255,255},
        fillPattern=FillPattern.Solid),
      Rectangle(
        extent={{-42,-8},{-14,20}},
        lineColor={255,255,255},
        fillColor={255,255,255},
        fillPattern=FillPattern.Solid),
      Rectangle(
        extent={{-42,-58},{-14,-30}},
        lineColor={255,255,255},
        fillColor={255,255,255},
        fillPattern=FillPattern.Solid),
      Rectangle(
        extent={{16,-58},{44,-30}},
        lineColor={255,255,255},
        fillColor={255,255,255},
        fillPattern=FillPattern.Solid)}));
end Rooms;
