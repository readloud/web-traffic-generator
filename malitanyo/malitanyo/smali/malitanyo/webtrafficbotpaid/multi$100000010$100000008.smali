.class Lmalitanyo/webtrafficbotpaid/multi$100000010$100000008;
.super Ljava/lang/Object;
.source "multi.java"

# interfaces
.implements Landroid/content/DialogInterface$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lmalitanyo/webtrafficbotpaid/multi$100000010;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x20
    name = "100000008"
.end annotation


# instance fields
.field private final this$0:Lmalitanyo/webtrafficbotpaid/multi$100000010;

.field private final val$modded:Ljava/util/Timer;

.field private final val$modded2:Ljava/util/Timer;

.field private final val$modded3:Ljava/util/Timer;

.field private final val$modded4:Ljava/util/Timer;


# direct methods
.method constructor <init>(Lmalitanyo/webtrafficbotpaid/multi$100000010;Ljava/util/Timer;Ljava/util/Timer;Ljava/util/Timer;Ljava/util/Timer;)V
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

    iput-object v8, v7, Lmalitanyo/webtrafficbotpaid/multi$100000010$100000008;->this$0:Lmalitanyo/webtrafficbotpaid/multi$100000010;

    move-object v7, v0

    move-object v8, v2

    iput-object v8, v7, Lmalitanyo/webtrafficbotpaid/multi$100000010$100000008;->val$modded:Ljava/util/Timer;

    move-object v7, v0

    move-object v8, v3

    iput-object v8, v7, Lmalitanyo/webtrafficbotpaid/multi$100000010$100000008;->val$modded2:Ljava/util/Timer;

    move-object v7, v0

    move-object v8, v4

    iput-object v8, v7, Lmalitanyo/webtrafficbotpaid/multi$100000010$100000008;->val$modded3:Ljava/util/Timer;

    move-object v7, v0

    move-object v8, v5

    iput-object v8, v7, Lmalitanyo/webtrafficbotpaid/multi$100000010$100000008;->val$modded4:Ljava/util/Timer;

    return-void
.end method

.method static access$0(Lmalitanyo/webtrafficbotpaid/multi$100000010$100000008;)Lmalitanyo/webtrafficbotpaid/multi$100000010;
    .locals 4

    move-object v0, p0

    move-object v3, v0

    iget-object v3, v3, Lmalitanyo/webtrafficbotpaid/multi$100000010$100000008;->this$0:Lmalitanyo/webtrafficbotpaid/multi$100000010;

    move-object v0, v3

    return-object v0
.end method


# virtual methods
.method public onClick(Landroid/content/DialogInterface;I)V
    .locals 5
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/content/DialogInterface;",
            "I)V"
        }
    .end annotation

    .prologue
    .line 233
    move-object v0, p0

    move-object v1, p1

    move v2, p2

    move-object v4, v0

    iget-object v4, v4, Lmalitanyo/webtrafficbotpaid/multi$100000010$100000008;->val$modded:Ljava/util/Timer;

    invoke-virtual {v4}, Ljava/util/Timer;->cancel()V

    .line 234
    move-object v4, v0

    iget-object v4, v4, Lmalitanyo/webtrafficbotpaid/multi$100000010$100000008;->val$modded2:Ljava/util/Timer;

    invoke-virtual {v4}, Ljava/util/Timer;->cancel()V

    .line 235
    move-object v4, v0

    iget-object v4, v4, Lmalitanyo/webtrafficbotpaid/multi$100000010$100000008;->val$modded3:Ljava/util/Timer;

    invoke-virtual {v4}, Ljava/util/Timer;->cancel()V

    .line 236
    move-object v4, v0

    iget-object v4, v4, Lmalitanyo/webtrafficbotpaid/multi$100000010$100000008;->val$modded4:Ljava/util/Timer;

    invoke-virtual {v4}, Ljava/util/Timer;->cancel()V

    .line 237
    move-object v4, v0

    iget-object v4, v4, Lmalitanyo/webtrafficbotpaid/multi$100000010$100000008;->this$0:Lmalitanyo/webtrafficbotpaid/multi$100000010;

    invoke-static {v4}, Lmalitanyo/webtrafficbotpaid/multi$100000010;->access$0(Lmalitanyo/webtrafficbotpaid/multi$100000010;)Lmalitanyo/webtrafficbotpaid/multi;

    move-result-object v4

    invoke-virtual {v4}, Lmalitanyo/webtrafficbotpaid/multi;->finish()V

    return-void
.end method
