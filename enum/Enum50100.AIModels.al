/// <summary>
/// Enum AI Models (ID 50100).
/// </summary>
enum 50100 "AI Models" implements Iautomate
{
    Extensible = true;

    
    value(1; "Ms copilot")
    {
        Caption = 'Ms copilot';
        Implementation = Iautomate ="Ms Copilot";
    }
    value(2; "Google Gemini")
    {
        Caption = 'Google Gemini';
        Implementation = Iautomate = Gemini;
    }
    value(3; "Meta Ai")
    {
        Caption = 'Meta Ai';
        Implementation = Iautomate = "Meta AI";
    }
    value(4; "Open Ai Chatgpt")
    {
        Caption = 'Open Ai Chatgpt';
        Implementation = Iautomate = GPT;
    }
}
