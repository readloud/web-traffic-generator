.class Lmalitanyo/webtrafficbotpaid/single$100000004;
.super Ljava/lang/Object;
.source "single.java"

# interfaces
.implements Landroid/view/View$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lmalitanyo/webtrafficbotpaid/single;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x20
    name = "100000004"
.end annotation

.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lmalitanyo/webtrafficbotpaid/single$100000004$100000002;,
        Lmalitanyo/webtrafficbotpaid/single$100000004$100000003;
    }
.end annotation


# instance fields
.field private final this$0:Lmalitanyo/webtrafficbotpaid/single;

.field private final val$modded:Ljava/util/Timer;


# direct methods
.method constructor <init>(Lmalitanyo/webtrafficbotpaid/single;Ljava/util/Timer;)V
    .locals 6

    move-object v0, p0

    move-object v1, p1

    move-object v2, p2

    move-object v4, v0

    invoke-direct {v4}, Ljava/lang/Object;-><init>()V

    move-object v4, v0

    move-object v5, v1

    iput-object v5, v4, Lmalitanyo/webtrafficbotpaid/single$100000004;->this$0:Lmalitanyo/webtrafficbotpaid/single;

    move-object v4, v0

    move-object v5, v2

    iput-object v5, v4, Lmalitanyo/webtrafficbotpaid/single$100000004;->val$modded:Ljava/util/Timer;

    return-void
.end method

.method static access$0(Lmalitanyo/webtrafficbotpaid/single$100000004;)Lmalitanyo/webtrafficbotpaid/single;
    .locals 4

    move-object v0, p0

    move-object v3, v0

    iget-object v3, v3, Lmalitanyo/webtrafficbotpaid/single$100000004;->this$0:Lmalitanyo/webtrafficbotpaid/single;

    move-object v0, v3

    return-object v0
.end method


# virtual methods
.method public onClick(Landroid/view/View;)V
    .locals 13
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
    .line 145
    move-object v0, p0

    move-object v1, p1

    move-object v6, v0

    iget-object v6, v6, Lmalitanyo/webtrafficbotpaid/single$100000004;->this$0:Lmalitanyo/webtrafficbotpaid/single;

    invoke-virtual {v6}, Lmalitanyo/webtrafficbotpaid/single;->getIntent()Landroid/content/Intent;

    move-result-object v6

    const-string v7, "URL"

    invoke-virtual {v6, v7}, Landroid/content/Intent;->getStringExtra(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v6

    move-object v3, v6

    .line 146
    new-instance v6, Landroid/app/AlertDialog$Builder;

    move-object v12, v6

    move-object v6, v12

    move-object v7, v12

    move-object v8, v0

    iget-object v8, v8, Lmalitanyo/webtrafficbotpaid/single$100000004;->this$0:Lmalitanyo/webtrafficbotpaid/single;

    invoke-direct {v7, v8}, Landroid/app/AlertDialog$Builder;-><init>(Landroid/content/Context;)V

    move-object v4, v6

    .line 147
    move-object v6, v4

    const v7, 0x108009b

    invoke-virtual {v6, v7}, Landroid/app/AlertDialog$Builder;->setIcon(I)Landroid/app/AlertDialog$Builder;

    move-result-object v6

    .line 148
    move-object v6, v4

    const-string v7, "NEED TO CONFIRM!"

    invoke-virtual {v6, v7}, Landroid/app/AlertDialog$Builder;->setTitle(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;

    move-result-object v6

    .line 149
    move-object v6, v4

    new-instance v7, Ljava/lang/StringBuffer;

    move-object v12, v7

    move-object v7, v12

    move-object v8, v12

    invoke-direct {v8}, Ljava/lang/StringBuffer;-><init>()V

    const-string v8, "Are you sure you want to Stop generating traffic into your blog/website and close this generator running?\n\nTARGET URL:\n"

    invoke-virtual {v7, v8}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    move-result-object v7

    move-object v8, v3

    invoke-virtual {v7, v8}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    move-result-object v7

    invoke-virtual {v7}, Ljava/lang/StringBuffer;->toString()Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v6, v7}, Landroid/app/AlertDialog$Builder;->setMessage(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;

    move-result-object v6

    .line 150
    move-object v6, v4

    const-string v7, "Yes"

    new-instance v8, Lmalitanyo/webtrafficbotpaid/single$100000004$100000002;

    move-object v12, v8

    move-object v8, v12

    move-object v9, v12

    move-object v10, v0

    move-object v11, v0

    iget-object v11, v11, Lmalitanyo/webtrafficbotpaid/single$100000004;->val$modded:Ljava/util/Timer;

    invoke-direct {v9, v10, v11}, Lmalitanyo/webtrafficbotpaid/single$100000004$100000002;-><init>(Lmalitanyo/webtrafficbotpaid/single$100000004;Ljava/util/Timer;)V

    invoke-virtual {v6, v7, v8}, Landroid/app/AlertDialog$Builder;->setPositiveButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    move-result-object v6

    .line 158
    move-object v6, v4

    const-string v7, "No"

    new-instance v8, Lmalitanyo/webtrafficbotpaid/single$100000004$100000003;

    move-object v12, v8

    move-object v8, v12

    move-object v9, v12

    move-object v10, v0

    invoke-direct {v9, v10}, Lmalitanyo/webtrafficbotpaid/single$100000004$100000003;-><init>(Lmalitanyo/webtrafficbotpaid/single$100000004;)V

    invoke-virtual {v6, v7, v8}, Landroid/app/AlertDialog$Builder;->setNegativeButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    move-result-object v6

    .line 163
    move-object v6, v4

    invoke-virtual {v6}, Landroid/app/AlertDialog$Builder;->show()Landroid/app/AlertDialog;

    move-result-object v6

    return-void
.end method
