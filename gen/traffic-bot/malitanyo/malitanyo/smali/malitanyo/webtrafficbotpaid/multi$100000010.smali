.class Lmalitanyo/webtrafficbotpaid/multi$100000010;
.super Ljava/lang/Object;
.source "multi.java"

# interfaces
.implements Landroid/view/View$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lmalitanyo/webtrafficbotpaid/multi;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x20
    name = "100000010"
.end annotation

.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lmalitanyo/webtrafficbotpaid/multi$100000010$100000008;,
        Lmalitanyo/webtrafficbotpaid/multi$100000010$100000009;
    }
.end annotation


# instance fields
.field private final this$0:Lmalitanyo/webtrafficbotpaid/multi;

.field private final val$modded:Ljava/util/Timer;

.field private final val$modded2:Ljava/util/Timer;

.field private final val$modded3:Ljava/util/Timer;

.field private final val$modded4:Ljava/util/Timer;


# direct methods
.method constructor <init>(Lmalitanyo/webtrafficbotpaid/multi;Ljava/util/Timer;Ljava/util/Timer;Ljava/util/Timer;Ljava/util/Timer;)V
    .locals 9

    move-object v0, p0

    move-object v1, p1

    move-object v2, p2

    move-object v3, p3

    move-object v4, p4

    move-object v5, p5

    move-object v7, v0

    invoke-direct {v7}, Ljava/lang/Object;-><init>()V

    move-object v7, v0

    move-object v8, v1

    iput-object v8, v7, Lmalitanyo/webtrafficbotpaid/multi$100000010;->this$0:Lmalitanyo/webtrafficbotpaid/multi;

    move-object v7, v0

    move-object v8, v2

    iput-object v8, v7, Lmalitanyo/webtrafficbotpaid/multi$100000010;->val$modded:Ljava/util/Timer;

    move-object v7, v0

    move-object v8, v3

    iput-object v8, v7, Lmalitanyo/webtrafficbotpaid/multi$100000010;->val$modded2:Ljava/util/Timer;

    move-object v7, v0

    move-object v8, v4

    iput-object v8, v7, Lmalitanyo/webtrafficbotpaid/multi$100000010;->val$modded3:Ljava/util/Timer;

    move-object v7, v0

    move-object v8, v5

    iput-object v8, v7, Lmalitanyo/webtrafficbotpaid/multi$100000010;->val$modded4:Ljava/util/Timer;

    return-void
.end method

.method static access$0(Lmalitanyo/webtrafficbotpaid/multi$100000010;)Lmalitanyo/webtrafficbotpaid/multi;
    .locals 4

    move-object v0, p0

    move-object v3, v0

    iget-object v3, v3, Lmalitanyo/webtrafficbotpaid/multi$100000010;->this$0:Lmalitanyo/webtrafficbotpaid/multi;

    move-object v0, v3

    return-object v0
.end method


# virtual methods
.method public onClick(Landroid/view/View;)V
    .locals 16
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
    .line 226
    move-object/from16 v0, p0

    move-object/from16 v1, p1

    move-object v6, v0

    iget-object v6, v6, Lmalitanyo/webtrafficbotpaid/multi$100000010;->this$0:Lmalitanyo/webtrafficbotpaid/multi;

    invoke-virtual {v6}, Lmalitanyo/webtrafficbotpaid/multi;->getIntent()Landroid/content/Intent;

    move-result-object v6

    const-string v7, "URL"

    invoke-virtual {v6, v7}, Landroid/content/Intent;->getStringExtra(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v6

    move-object v3, v6

    .line 227
    new-instance v6, Landroid/app/AlertDialog$Builder;

    move-object v15, v6

    move-object v6, v15

    move-object v7, v15

    move-object v8, v0

    iget-object v8, v8, Lmalitanyo/webtrafficbotpaid/multi$100000010;->this$0:Lmalitanyo/webtrafficbotpaid/multi;

    invoke-direct {v7, v8}, Landroid/app/AlertDialog$Builder;-><init>(Landroid/content/Context;)V

    move-object v4, v6

    .line 228
    move-object v6, v4

    const v7, 0x108009b

    invoke-virtual {v6, v7}, Landroid/app/AlertDialog$Builder;->setIcon(I)Landroid/app/AlertDialog$Builder;

    move-result-object v6

    .line 229
    move-object v6, v4

    const-string v7, "NEED TO CONFIRM!"

    invoke-virtual {v6, v7}, Landroid/app/AlertDialog$Builder;->setTitle(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;

    move-result-object v6

    .line 230
    move-object v6, v4

    new-instance v7, Ljava/lang/StringBuffer;

    move-object v15, v7

    move-object v7, v15

    move-object v8, v15

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

    .line 231
    move-object v6, v4

    const-string v7, "Yes"

    new-instance v8, Lmalitanyo/webtrafficbotpaid/multi$100000010$100000008;

    move-object v15, v8

    move-object v8, v15

    move-object v9, v15

    move-object v10, v0

    move-object v11, v0

    iget-object v11, v11, Lmalitanyo/webtrafficbotpaid/multi$100000010;->val$modded:Ljava/util/Timer;

    move-object v12, v0

    iget-object v12, v12, Lmalitanyo/webtrafficbotpaid/multi$100000010;->val$modded2:Ljava/util/Timer;

    move-object v13, v0

    iget-object v13, v13, Lmalitanyo/webtrafficbotpaid/multi$100000010;->val$modded3:Ljava/util/Timer;

    move-object v14, v0

    iget-object v14, v14, Lmalitanyo/webtrafficbotpaid/multi$100000010;->val$modded4:Ljava/util/Timer;

    invoke-direct/range {v9 .. v14}, Lmalitanyo/webtrafficbotpaid/multi$100000010$100000008;-><init>(Lmalitanyo/webtrafficbotpaid/multi$100000010;Ljava/util/Timer;Ljava/util/Timer;Ljava/util/Timer;Ljava/util/Timer;)V

    invoke-virtual {v6, v7, v8}, Landroid/app/AlertDialog$Builder;->setPositiveButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    move-result-object v6

    .line 241
    move-object v6, v4

    const-string v7, "No"

    new-instance v8, Lmalitanyo/webtrafficbotpaid/multi$100000010$100000009;

    move-object v15, v8

    move-object v8, v15

    move-object v9, v15

    move-object v10, v0

    invoke-direct {v9, v10}, Lmalitanyo/webtrafficbotpaid/multi$100000010$100000009;-><init>(Lmalitanyo/webtrafficbotpaid/multi$100000010;)V

    invoke-virtual {v6, v7, v8}, Landroid/app/AlertDialog$Builder;->setNegativeButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    move-result-object v6

    .line 246
    move-object v6, v4

    invoke-virtual {v6}, Landroid/app/AlertDialog$Builder;->show()Landroid/app/AlertDialog;

    move-result-object v6

    return-void
.end method
