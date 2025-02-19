namespace TrialVersion.TrialVersion;

using Microsoft.Purchases.Vendor;

pageextension 50103 "Vendor list ext" extends "Vendor List"
{
    layout
    {
        addbefore(VendorStatisticsFactBox)
        {
            part(Stats; "Vendor Purchase stats")
            {
                SubPageLink = "No." = field("No.");
                ApplicationArea = all;
            }
        }
    }
}
