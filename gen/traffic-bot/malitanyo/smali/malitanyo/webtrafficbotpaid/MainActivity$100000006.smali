.class Lmalitanyo/webtrafficbotpaid/MainActivity$100000006;
.super Ljava/lang/Object;
.source "MainActivity.java"

# interfaces
.implements Landroid/view/View$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lmalitanyo/webtrafficbotpaid/MainActivity;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x20
    name = "100000006"
.end annotation


# instance fields
.field private final this$0:Lmalitanyo/webtrafficbotpaid/MainActivity;


# direct methods
.method constructor <init>(Lmalitanyo/webtrafficbotpaid/MainActivity;)V
    .locals 5

    move-object v0, p0

    move-object v1, p1

    move-object v3, v0

    invoke-direct {v3}, Ljava/lang/Object;-><init>()V

    move-object v3, v0

    move-object v4, v1

    iput-object v4, v3, Lmalitanyo/webtrafficbotpaid/MainActivity$100000006;->this$0:Lmalitanyo/webtrafficbotpaid/MainActivity;

    return-void
.end method

.method static access$0(Lmalitanyo/webtrafficbotpaid/MainActivity$100000006;)Lmalitanyo/webtrafficbotpaid/MainActivity;
    .locals 4

    move-object v0, p0

    move-object v3, v0

    iget-object v3, v3, Lmalitanyo/webtrafficbotpaid/MainActivity$100000006;->this$0:Lmalitanyo/webtrafficbotpaid/MainActivity;

    move-object v0, v3

    return-object v0
.end method


# virtual methods
.method public onClick(Landroid/view/View;)V
    .locals 12
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/view/View;",
            ")V"
        }
    .end annotation

    .annotation runtime Ljava/lang/Override;
    .end annotation

    .prologue
    .line 182
    move-object v0, p0

    move-object v1, p1

    new-instance v5, Landroid/content/Intent;

    move-object v11, v5

    move-object v5, v11

    move-object v6, v11

    const-string v7, "android.intent.action.SEND"

    invoke-direct {v6, v7}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    move-object v3, v5

    .line 183
    move-object v5, v3

    const-string v6, "android.intent.extra.EMAIL"

    const/4 v7, 0x1

    new-array v7, v7, [Ljava/lang/String;

    move-object v11, v7

    move-object v7, v11

    move-object v8, v11

    const/4 v9, 0x0

    const-string v10, "allanzamora999@gmail.com"

    aput-object v10, v8, v9

    invoke-virtual {v5, v6, v7}, Landroid/content/Intent;->putExtra(Ljava/lang/String;[Ljava/lang/String;)Landroid/content/Intent;

    move-result-object v5

    .line 186
    move-object v5, v3

    const-string v6, "android.intent.extra.SUBJECT"

    const-string v7, "Web Traffic Bot PAID"

    invoke-virtual {v5, v6, v7}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    move-result-object v5

    .line 187
    move-object v5, v3

    const-string v6, "android.intent.extra.TEXT"

    const-string v7, ""

    invoke-virtual {v5, v6, v7}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    move-result-object v5

    .line 190
    move-object v5, v3

    const-string v6, "message/rfc822"

    invoke-virtual {v5, v6}, Landroid/content/Intent;->setType(Ljava/lang/String;)Landroid/content/Intent;

    move-result-object v5

    .line 192
    move-object v5, v0

    iget-object v5, v5, Lmalitanyo/webtrafficbotpaid/MainActivity$100000006;->this$0:Lmalitanyo/webtrafficbotpaid/MainActivity;

    move-object v6, v3

    const-string v7, "Choose an Email client :"

    invoke-static {v6, v7}, Landroid/content/Intent;->createChooser(Landroid/content/Intent;Ljava/lang/CharSequence;)Landroid/content/Intent;

    move-result-object v6

    invoke-virtual {v5, v6}, Lmalitanyo/webtrafficbotpaid/MainActivity;->startActivity(Landroid/content/Intent;)V

    return-void
.end method
