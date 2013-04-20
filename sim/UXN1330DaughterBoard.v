module UXN1330DaughterBoard
  (
   inout scl,
   inout sda,
`ifdef USER_DATA_WIDTH
   inout[`USER_DATA_WIDTH-1:0] user_data,
`endif
   
   inout l10n,
   inout l10p,
   inout l11n,
   inout l11p,
   inout l1p,
   inout l1n,
   inout l2n,
   inout l2p,
   inout l32n,
   inout l32p,
   inout l33n,
   inout l33p,
   inout l34n,
   inout l34p,
   inout l35n,
   inout l35p,
   inout l36n,
   inout l36p,
   inout l37n,
   inout l37p,
   inout l38n,
   inout l38p,
   inout l39n,
   inout l39p,
   inout l3n,
   inout l3p,
   inout l40n,
   inout l40p,
   inout l41n,
   inout l41p,
   inout l42n,
   inout l42p,
   inout l47n,
   inout l47p,
   inout l4n,
   inout l4p,
   inout l50n,
   inout l50p,
   inout l51n,
   inout l51p,
   inout l5n,
   inout l5p,
   inout l62n,
   inout l62p,
   inout l63n,
   inout l63p,
   inout l64n,
   inout l64p,
   inout l65n,
   inout l65p,
   inout l66n,
   inout l66p,
   inout l6n,
   inout l6p,
   inout l7n,
   inout l7p,
   inout l8n,
   inout l8p,
   inout l9n,
   inout l9p,
   
   inout n1n,
   inout n1p,
   inout n29n,
   inout n29p,
   inout n30n,
   inout n30p,
   inout n31n,
   inout n31p,
   inout n32n,
   inout n32p,
   inout n33n,
   inout n33p,
   inout n34n,
   inout n34p,
   inout n35n,
   inout n35p,
   inout n36n,
   inout n36p,
   inout n37n,
   inout n37p,
   inout n38n,
   inout n38p,
   inout n39n,
   inout n39p,
   inout n40n,
   inout n40p,
   inout n41n,
   inout n41p,
   inout n42n,
   inout n42p,
   inout n43n,
   inout n43p,
   inout n44n,
   inout n44p,
   inout n45n,
   inout n45p,
   inout n46n,
   inout n46p,
   inout n47n,
   inout n47p,
   inout n48n,
   inout n48p,
   inout n49n,
   inout n49p,
   inout n50n,
   inout n50p,
   inout n51n,
   inout n51p,
   inout n52n,
   inout n52p,
   inout n53n,
   inout n53p,
   inout n61n,
   inout n61p,
   inout n74n,
   inout n74p
   );


endmodule
