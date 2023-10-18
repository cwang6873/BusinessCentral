page 50900 "Active User Sessions"
{
    ApplicationArea = All;
    Caption = 'Currently Logged In User Sessions';
    PageType = List;
    SourceTable = "Active Session";
    SourceTableTemporary = true;
    UsageCategory = Lists;
    InsertAllowed = false;
    Editable = false;
    DeleteAllowed = false;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("User ID"; Rec."User ID")
                {
                    ToolTip = 'Specifies the value of the User ID field.';
                }
                field("Session ID"; Rec."Session ID")
                {
                    ToolTip = 'Specifies the value of the Session ID field.';
                }
                field("User SID"; Rec."User SID")
                {
                    ToolTip = 'Specifies the value of the User SID field.';
                }
                field("Client Computer Name"; Rec."Client Computer Name")
                {
                    ToolTip = 'Specifies the value of the Client Computer Name field.';
                }
                field("Client Type"; Rec."Client Type")
                {
                    ToolTip = 'Specifies the value of the Client Type field.';
                }
                field("Login Datetime"; Rec."Login Datetime")
                {
                    ToolTip = 'Specifies the value of the Login Datetime field.';
                }
                field("Server Computer Name"; Rec."Server Computer Name")
                {
                    ToolTip = 'Specifies the value of the Server Computer Name field.';
                }
            }
        }
    }

    trigger OnOpenPage()
    var
        ActiveSession: Record "Active Session";
        LastUserID: Text[132];
    begin
        LastUserID := '';
        ActiveSession.Reset();
        ActiveSession.SetCurrentKey("User ID");
        ActiveSession.Ascending(true);
        if ActiveSession.FindSet() then
            repeat
                if not (ActiveSession."User ID" = LastUserID) then begin
                    Rec.Init();
                    Rec."User ID" := ActiveSession."User ID";
                    Rec."Session ID" := ActiveSession."Session ID";
                    Rec."User SID" := ActiveSession."User SID";
                    Rec."Client Computer Name" := ActiveSession."Client Computer Name";
                    Rec."Client Type" := ActiveSession."Client Type";
                    Rec."Login Datetime" := ActiveSession."Login Datetime";
                    Rec."Server Computer Name" := ActiveSession."Server Computer Name";
                    Rec.Insert();
                    LastUserID := ActiveSession."User ID";
                end;
            until ActiveSession.Next() = 0;
    end;
}
